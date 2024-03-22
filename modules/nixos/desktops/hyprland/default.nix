{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.hyprland;
  user = config.users.mainUser;
in
{
  options.desktop.hyprland.enable = mkBoolOpt false "Enable hyprland configuration.";
  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    services.xserver.displayManager.defaultSession = "hyprland";
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    programs.nm-applet.enable = true;
    environment.systemPackages = with pkgs; [
      # QT stuff
      kdePackages.breeze
      kdePackages.breeze-icons
      libsForQt5.breeze-icons

      # inputs.hyprsome.packages.${pkgs.system}.default
      custom.hyprsome
      swaybg
      mpvpaper
      swaynotificationcenter

      pavucontrol
      overskride

      gnome.nautilus
      nautilus-open-any-terminal
      celluloid
      loupe

      wl-clipboard
      rofi-wayland
      grimblast
      swaylock
      (writeShellScriptBin "dnd" ''
        pause_noti () {
          makoctl dismiss -a
          makoctl mode -a dnd
        }

        unpause_noti () {
          makoctl mode -r dnd
        }

        toggle_noti () {
          if [ "$(makoctl mode | tail -n 1)" = "default" ]; then
            pause_noti
          else
            unpause_noti
          fi
        }

        if getopts 'tpu' flag; then
          case "$flag" in
            t) toggle_noti exit;;
            p) pause_noti exit;;
            u) unpause_noti exit;;
          esac
        else
          echo "Usage: -p 'pause', -u 'unpause' -t 'toggle'"
        fi
      '')
    ];
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };
    snowfallorg.users.${user}.home.config = {
      apps.rofi.enable = true;
      services.udiskie.enable = true;
      programs.ironbar = {
        enable = true;
        config = import ./ironbar.nix;
      };
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.variables = ["-all"];
        settings = {
          "$fm" = "nautilus";
          "$browser" = "floorp";
          "$terminal" = "footclient";

          "exec-once" = [
            "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "swaync"
          ];

          exec = [
            "swaybg --image ~/.background-image --mode fill"
            "ironbar waybar; ironbar"
          ];

          general = {
            gaps_in = 2;
            gaps_out = 4;
            border_size = 3;
          };

          misc = {
            vrr = 1;
            disable_splash_rendering = true;
          };

          decoration = {
            rounding = 8;
          };

          windowrule = "float,Rofi";

          bindm = [
            "SUPER,mouse:272,movewindow"
            "SUPER,mouse:273,resizewindow"
          ];

          bind = [
            # Menus
            "SUPER,SPACE,exec,rofi-wrapper -r,"
            "SUPER,O,exec,rofi-wrapper -o,"

            # Program binds
            "SUPER,Return,exec,$terminal"
            "SUPER,B,exec,$browser"
            "SUPER,E,exec,$fm"

            # Volume keys
            ",XF86AudioLowerVolume,exec,pamixer -d 10"
            "SHIFT,XF86AudioLowerVolume,exec,pamixer --allow-boost -d 10"
            ",XF86AudioRaiseVolume,exec,pamixer -i 10"
            "SHIFT,XF86AudioRaiseVolume,exec,pamixer --allow-boost -i 10"
            ",XF86AudioMute,exec,pamixer -t"

            # Brightness keys
            ",XF86MonBrightnessUp,exec,brightnessctl s +10%"
            ",XF86MonBrightnessDown,exec,brightnessctl s 10%-"

            # Do not disturb
            "SUPER,N,exec,togdnd -t"

            # Screenshots
            "SUPERSHIFT,S,exec,grimblast copy area"
            "SUPERSHIFTCTRL,S,exec,copysave area"
            "SUPER,S,exec,grimblast copy active"
            "SUPERCTRL,S,exec,grimblast copysave active"
            "SUPERALT,S,exec,grimblast copy output"
            "SUPERALTCTRL,S,exec,grimblast copysave output"

            # Window management
            "SUPER,Q,killactive,"
            "SUPERSHIFT,Q,exec,xkill"

            "SUPER,F,fullscreen"
            "SUPERALT,F,fakefullscreen"
            "SUPERSHIFT,F,togglefloating,"

            "SUPER,h,movefocus,l"
            "SUPER,l,movefocus,r"
            "SUPER,k,movefocus,u"
            "SUPER,j,movefocus,d"

            "SUPERSHIFT,h,movewindow,l"
            "SUPERSHIFT,l,movewindow,r"
            "SUPERSHIFT,k,movewindow,u"
            "SUPERSHIFT,j,movewindow,d"

            "SUPER,1,exec,hyprsome workspace 1"
            "SUPER,2,exec,hyprsome workspace 2"
            "SUPER,3,exec,hyprsome workspace 3"
            "SUPER,4,exec,hyprsome workspace 4"
            "SUPER,5,exec,hyprsome workspace 5"
            "SUPER,6,exec,hyprsome workspace 6"
            "SUPER,7,exec,hyprsome workspace 7"
            "SUPER,8,exec,hyprsome workspace 8"
            "SUPER,9,exec,hyprsome workspace 9"

            "SUPERALT,1,exec,hyprsome movefocus 1"
            "SUPERALT,2,exec,hyprsome movefocus 2"
            "SUPERALT,3,exec,hyprsome movefocus 3"
            "SUPERALT,4,exec,hyprsome movefocus 4"
            "SUPERALT,5,exec,hyprsome movefocus 5"
            "SUPERALT,6,exec,hyprsome movefocus 6"
            "SUPERALT,7,exec,hyprsome movefocus 7"
            "SUPERALT,8,exec,hyprsome movefocus 8"
            "SUPERALT,9,exec,hyprsome movefocus 9"
            "SUPERSHIFT,1,exec,hyprsome move 1"
            "SUPERSHIFT,2,exec,hyprsome move 2"
            "SUPERSHIFT,3,exec,hyprsome move 3"
            "SUPERSHIFT,4,exec,hyprsome move 4"
            "SUPERSHIFT,5,exec,hyprsome move 5"
            "SUPERSHIFT,6,exec,hyprsome move 6"
            "SUPERSHIFT,7,exec,hyprsome move 7"
            "SUPERSHIFT,8,exec,hyprsome move 8"
            "SUPERSHIFT,9,exec,hyprsome move 9"
          ];
        };
      };
    };
  };
}
