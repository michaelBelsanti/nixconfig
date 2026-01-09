{
  styx,
  inputs,
  lib,
  niri-lib,
  den,
  ...
}:
{
  styx.wayland._.niri =
    { host, ... }:
    den.lib.parametric.fixedTo { inherit host; } {
      includes = [
        styx.wayland._.base
        styx.apps._.vicinae
      ];
      nixos =
        { config, pkgs, ... }:
        {
          imports = [ inputs.dank-material-shell.nixosModules.greeter ];
          environment.systemPackages = with pkgs; [
            xwayland-satellite
            cosmic-files
            file-roller
            nautilus
            satty
            celluloid
            loupe
          ];
          programs = {
            niri.enable = true;
            niri.package = pkgs.niri;
            dank-material-shell.greeter = {
              enable = true;
              configHome = "/home/quasi";
              compositor.name = "niri";
              compositor.customConfig =
                inputs.niri.lib.kdl.serialize.nodes (
                  builtins.filter (
                    n:
                    lib.elem n.name [
                      "output"
                      "layout"
                      "hotkey-overlay"
                      "input"
                      "cursor"
                    ]
                  ) config.home-manager.users.quasi.programs.niri.config
                )
                + ''
                  environment {
                      DMS_RUN_GREETER "1"
                  }

                  gestures {
                    hot-corners {
                      off
                    }
                  }
                '';
            };
          };
          services = {
            greetd.settings.default_session.user = "quasi";
            geoclue2 = {
              enable = true;
              enableDemoAgent = true;
            };
          };
        };
      homeManager =
        {
          pkgs,
          config,
          ...
        }:
        {
          imports = [
            inputs.niri.homeModules.config
            inputs.dank-material-shell.homeModules.dank-material-shell
          ];
          services.swww.enable = true;
          home.packages = with pkgs; [
            # Used by vicinae extensions
            playerctl
            pulseaudio # pactl
            brotab
            swww
          ];
          programs.dank-material-shell = {
            enable = true;
            systemd.enable = true;
          };
          dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
          xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
          qt.platformTheme.name = "qtct";
          gtk.theme = {
            package = pkgs.colloid-gtk-theme;
            name = "Colloid";
          };
          programs.niri.settings = {
            input = {
              mouse.accel-profile = "flat";
              warp-mouse-to-focus.enable = true;
              focus-follows-mouse = {
                enable = true;
                max-scroll-amount = "0%";
              };
              touchpad = {
                tap = true;
                dwt = true;
                drag = true;
                click-method = "clickfinger";
                scroll-method = "two-finger";
              };
            };

            outputs = lib.mapAttrs (
              _: v: with v; {
                mode = { inherit width height refresh; };
                scale = scaling;
                position = { inherit x y; };
                variable-refresh-rate = vrr;
                focus-at-startup = lib.mkIf primary true;
              }
            ) host.displays;

            spawn-at-startup = [
              {
                argv = [
                  "swww"
                  "img"
                  (inputs.self + /assets/campfire.gif)
                ];
              }
            ];

            cursor.theme = config.home.pointerCursor.name;

            prefer-no-csd = true;

            hotkey-overlay = {
              hide-not-bound = true;
              skip-at-startup = true;
            };

            layout = {
              border = {
                enable = false;
                width = 1;
              };
              focus-ring.enable = true;
              shadow.enable = true;
              gaps = 8;
              default-column-width.proportion = 1.0;
            };

            window-rules = [
              {
                geometry-corner-radius = {
                  top-left = 12.0;
                  top-right = 12.0;
                  bottom-left = 12.0;
                  bottom-right = 12.0;
                };
                clip-to-geometry = true;
              }
            ];

            binds =
              let
                dms = cmd: { spawn-sh = "dms ipc " + cmd; };
              in
              lib.attrsets.mergeAttrsList [
                {
                  "Mod+Q".action.close-window = [ ];

                  "Mod+Space".action.spawn-sh = "vicinae toggle";
                  "Mod+Shift+Space".action.spawn-sh = "systemctl --user restart vicinae.service";

                  "Mod+Return".action.spawn = "wezterm";
                  "Mod+B".action.spawn = "zen";

                  "Mod+W".action.toggle-overview = [ ];
                  "Mod+O".action.show-hotkey-overlay = [ ];

                  "Mod+Escape".action = dms "lock lock";

                  "Mod+Shift+S".action.screenshot = [ ];
                  "Mod+S".action.screenshot-window = [ ];
                  "Mod+Ctrl+S".action.spawn-sh = "niri msg action screenshot-screen && wl-paste | satty -f -";

                  # "Mod+Insert".action = set-dynamic-cast-window;
                  # "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
                  # "Mod+Delete".action = clear-dynamic-cast-target;

                  XF86AudioRaiseVolume = {
                    allow-when-locked = true;
                    action = dms "audio increment 3";
                  };
                  XF86AudioLowerVolume = {
                    allow-when-locked = true;
                    action = dms "audio decrement 3";
                  };
                  XF86AudioMute = {
                    allow-when-locked = true;
                    action = dms "audio mute";
                  };
                  XF86AudioMicMute = {
                    allow-when-locked = true;
                    action = dms "audio micmute";
                  };

                  XF86AudioPlay = {
                    allow-when-locked = true;
                    action = dms "mpris playPause";
                  };
                  XF86AudioNext = {
                    allow-when-locked = true;
                    action = dms "mpris next";
                  };
                  XF86AudioPrev = {
                    allow-when-locked = true;
                    action = dms "mpris prev";
                  };

                  XF86MonBrightnessUp.action = dms "brightness increment 5";
                  XF86MonBrightnessDown.action = dms "brightness decrement 5";

                  "Mod+T".action.toggle-column-tabbed-display = [ ];

                  # "Mod+Tab".action = focus-window-down-or-column-right;
                  # "Mod+Shift+Tab".action = focus-window-up-or-column-left;

                  "Mod+G".action.switch-focus-between-floating-and-tiling = [ ];

                  "Mod+H".action.focus-column-or-monitor-left = [ ];
                  "Mod+J".action.focus-window-or-monitor-down = [ ];
                  "Mod+K".action.focus-window-or-monitor-up = [ ];
                  "Mod+L".action.focus-column-or-monitor-right = [ ];

                  "Mod+Shift+H".action.move-column-left-or-to-monitor-left = [ ];
                  "Mod+Shift+J".action.move-window-down = [ ];
                  "Mod+Shift+K".action.move-window-up = [ ];
                  "Mod+Shift+L".action.move-column-right-or-to-monitor-right = [ ];

                  "Mod+WheelScrollDown".action.focus-column-right = [ ];
                  "Mod+WheelScrollUp".action.focus-column-left = [ ];
                }
                (niri-lib.binds {
                  suffixes."H" = "monitor-left";
                  suffixes."J" = "monitor-down";
                  suffixes."K" = "monitor-up";
                  suffixes."L" = "monitor-right";
                  prefixes."Mod+Ctrl" = "focus";
                  prefixes."Mod+Ctrl+Shift" = "move-column-to";
                })
                (niri-lib.binds {
                  suffixes."Home" = "first";
                  suffixes."End" = "last";
                  prefixes."Mod" = "focus-column";
                  prefixes."Mod+Ctrl" = "move-column-to";
                })
                (niri-lib.binds {
                  suffixes = builtins.listToAttrs (
                    map (n: {
                      name = toString n;
                      value = [
                        "workspace"
                        n
                      ];
                    }) (lib.range 1 9)
                  );
                  prefixes."Mod" = "focus";
                  prefixes."Mod+Shift" = "move-column-to";
                })
                {
                  "Mod+Comma".action.consume-window-into-column = [ ];
                  "Mod+Period".action.expel-window-from-column = [ ];

                  "Mod+R".action.switch-preset-column-width = [ ];
                  "Mod+E".action.switch-preset-column-width-back = [ ];
                  "Mod+F".action.maximize-column = [ ];
                  "Mod+Shift+F".action.fullscreen-window = [ ];
                  "Mod+C".action.center-column = [ ];

                  "Mod+Shift+Escape".action.toggle-keyboard-shortcuts-inhibit = [ ];
                  "Mod+Shift+Ctrl+T".action.toggle-debug-tint = [ ];
                  "Ctrl+Alt+Delete".action.quit = [ ];
                }
              ];
          };
        };
    };
}
