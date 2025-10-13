{
  inputs,
  lib,
  niri-lib,
  ...
}:
{
  unify.modules.niri = {
    nixos =
      {
        pkgs,
        homeConfig,
        hostConfig,
        ...
      }:
      {
        imports = [ inputs.dank-material-shell.nixosModules.greeter ];
        programs.niri.enable = true;
        programs.niri.package = pkgs.niri;
        services.greetd.settings.default_session.user = "${hostConfig.primaryUser}";
        programs.dankMaterialShell.greeter = {
          enable = true;
          compositor.name = "niri";
          configHome = "${homeConfig.home.homeDirectory}";
        };
      };
    home =
      { hostConfig, config, ... }:
      {
        imports = [
          inputs.niri.homeModules.config
          inputs.dank-material-shell.homeModules.dankMaterialShell.default
        ];
        programs.dankMaterialShell = {
          enable = true;
          enableSystemd = true;
        };
        programs.niri.settings = {
          input = {
            mouse.accel-profile = "flat";
            warp-mouse-to-focus.enable = true;
            focus-follows-mouse = {
              enable = true;
              max-scroll-amount = "10%";
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
          ) hostConfig.displays;

          cursor.theme = config.home.pointerCursor.name;

          layout = {
            border.enable = false;
            focus-ring.enable = true;
          };

          binds =
            with config.lib.niri.actions;
            let
              inherit (niri-lib) binds;
              dms = spawn "dms" "ipc";
            in
            lib.attrsets.mergeAttrsList [
              {
                "Mod+Q".action = close-window;

                "Mod+Space".action = spawn "vicinae";
                "Mod+Shift+Space".action = spawn-sh "systemctl --user restart vicinae.service";

                "Mod+Return".action = spawn "wezterm";
                "Mod+B".action = spawn "zen";

                "Mod+O".action = show-hotkey-overlay;

                "Mod+Escape".action = dms "lock" "lock";

                # "Mod+Shift+S".action = screenshot;
                # "Print".action.screenshot-screen = [ ];
                # "Mod+Print".action = screenshot-window;

                # "Mod+Insert".action = set-dynamic-cast-window;
                # "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
                # "Mod+Delete".action = clear-dynamic-cast-target;

                "XF86AudioRaiseVolume" = {
                  allow-when-locked = true;
                  action = dms "audio" "increment" "3";
                };
                "XF86AudioLowerVolume" = {
                  allow-when-locked = true;
                  action = dms "audio" "decrement" "3";
                };
                "XF86AudioMute" = {
                  allow-when-locked = true;
                  action = dms "audio" "mute";
                };
                "XF86AudioMicMute" = {
                  allow-when-locked = true;
                  action = dms "audio" "micmute";
                };

                "XF86AudioPlay" = {
                  allow-when-locked = true;
                  action = dms "mpris" "playPause";
                };
                "XF86AudioNext" = {
                  allow-when-locked = true;
                  action = dms "mpris" "next";
                };
                "XF86AudioPrev" = {
                  allow-when-locked = true;
                  action = dms "mpris" "prev";
                };

                "XF86MonBrightnessUp".action = dms "brightness" "increment" "5";
                "XF86MonBrightnessDown".action = dms "brightness" "decrement" "5";

                "Mod+T".action = toggle-column-tabbed-display;

                # "Mod+Tab".action = focus-window-down-or-column-right;
                # "Mod+Shift+Tab".action = focus-window-up-or-column-left;

                "Mod+G".action = switch-focus-between-floating-and-tiling;
              }
              (binds {
                suffixes."H" = "column-left";
                suffixes."J" = "window-down";
                suffixes."K" = "window-up";
                suffixes."L" = "column-right";
                prefixes."Mod" = "focus";
                prefixes."Mod+Shift" = "move";
                prefixes."Mod+Ctrl" = "focus-monitor";
                prefixes."Mod+Shift+Ctrl" = "move-window-to-monitor";
                substitutions."monitor-column" = "monitor";
                substitutions."monitor-window" = "monitor";
              })
              (binds {
                suffixes."Home" = "first";
                suffixes."End" = "last";
                prefixes."Mod" = "focus-column";
                prefixes."Mod+Ctrl" = "move-column-to";
              })
              (binds {
                suffixes."D" = "workspace-down";
                suffixes."U" = "workspace-up";
                prefixes."Mod" = "focus";
                prefixes."Mod+Ctrl" = "move-window-to";
                prefixes."Mod+Shift" = "move";
              })
              (binds {
                suffixes = builtins.listToAttrs (
                  map (n: {
                    name = toString n;
                    value = [
                      "workspace"
                      (n + 1)
                    ]; # workspace 1 is empty; workspace 2 is the logical first.
                  }) (lib.range 1 9)
                );
                prefixes."Mod" = "focus";
                prefixes."Mod+Shift" = "move-window-to";
              })
              {
                "Mod+Comma".action = consume-window-into-column;
                "Mod+Period".action = expel-window-from-column;

                "Mod+R".action = switch-preset-column-width;
                "Mod+F".action = maximize-column;
                "Mod+Shift+F".action = fullscreen-window;
                "Mod+C".action = center-column;

                "Mod+Minus".action = set-column-width "-10%";
                "Mod+Plus".action = set-column-width "+10%";
                "Mod+Shift+Minus".action = set-window-height "-10%";
                "Mod+Shift+Plus".action = set-window-height "+10%";

                "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;

                "Mod+Shift+Ctrl+T".action = toggle-debug-tint;
              }
            ];
        };
      };
  };
}
