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
    environment.systemPackages = with pkgs; [
      swaybg
      waybar
      # (waybar.overrideAttrs (oldAttrs: {
      #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      # }))
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
    snowfallorg.users.${user}.home.config = {
      apps.rofi.enable = true;
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$fm" = "dolphin";
          "$browser" = config.environment.variables.BROWSER;
          "$terminal" = "footclient";

          "exec-once" = [
            "mako"
            "foot --server"
            "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"
          ];
          exec = [
            "pkill waybar; waybar"
            "swaybg --image ~/.background-image --mode fill"
          ];
          general = {
            gaps_in = 2;
            gaps_out = 4;
            border_size = 3;
            col.active_border = "0xffebbcba";
            col.inactive_border = "0xff191724";
          };
          misc = {
            vrr = 1;
            disable_splash_rendering = true;
          };
          decoration = {
            rounding = 8;
          };
          animations = {
            enabled=1;
            animation = [
              "windows,1,3,default"
              "border,1,5,default"
              "fade,1,4,default"
              "workspaces,1,3,default,fade"
            ];
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

            "SUPER,1,workspace,1"
            "SUPER,2,workspace,2"
            "SUPER,3,workspace,3"
            "SUPER,4,workspace,4"
            "SUPER,5,workspace,5"
            "SUPER,6,workspace,6"
            "SUPER,7,workspace,7"
            "SUPER,8,workspace,8"
            "SUPER,9,workspace,9"
            "SUPER,0,workspace,10"

            "SUPERALT,1,movetoworkspace,1"
            "SUPERALT,2,movetoworkspace,2"
            "SUPERALT,3,movetoworkspace,3"
            "SUPERALT,4,movetoworkspace,4"
            "SUPERALT,5,movetoworkspace,5"
            "SUPERALT,6,movetoworkspace,6"
            "SUPERALT,7,movetoworkspace,7"
            "SUPERALT,8,movetoworkspace,8"
            "SUPERALT,9,movetoworkspace,9"
            "SUPERSHIFT,1,movetoworkspacesilent,1"
            "SUPERSHIFT,2,movetoworkspacesilent,2"
            "SUPERSHIFT,3,movetoworkspacesilent,3"
            "SUPERSHIFT,4,movetoworkspacesilent,4"
            "SUPERSHIFT,5,movetoworkspacesilent,5"
            "SUPERSHIFT,6,movetoworkspacesilent,6"
            "SUPERSHIFT,7,movetoworkspacesilent,7"
            "SUPERSHIFT,8,movetoworkspacesilent,8"
            "SUPERSHIFT,9,movetoworkspacesilent,9"
          ];
        };
      };
    };
  };
}
