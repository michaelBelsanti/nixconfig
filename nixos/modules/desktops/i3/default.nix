{
  pkgs,
  user,
  ...
}: {
  imports = [../default.nix];
  services.xserver.windowManager.i3.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-kde];
  environment.systemPackages = with pkgs; [
    picom
    betterlockscreen
    shotgun
    hacksaw
    rofi
    feh
    dunst
    xdotool
    xorg.xkill
    xclip
    autotiling
    (polybar.override {
      i3Support = true;
      pulseSupport = true;
    })
  ];
  home-manager.users.${user} = {
    imports = [../rofi];
    xdg.configFile = {
      "i3/config".source = ./config;
      picom = {
        source = ./picom;
        recursive = true;
      };
      polybar = {
        source = ./polybar;
        recursive = true;
      };
      dunst = {
        source = ./dunst;
        recursive = true;
      };
    };
    # Scripts
    home.packages = with pkgs; [
      (writeShellScriptBin "togpicom" ''
        stop () {
          killall picom
        }
        start () {
          picom --unredir-if-possible
        }

        pgrep -x picom
        if [ $? -ne 0 ]
          then ALIVE=0
          else ALIVE=1
        fi;

        if getopts 'tpu' flag; then
          case "$flag" in
            t) if [ $ALIVE -eq 1 ]; then stop; else start; fi; exit;;
            p) stop exit;;
            u) start exit;;
          esac
        else
          echo "Usage: -p 'pause', -u 'unpause' -t 'toggle'"
        fi
      '')

      (writeShellScriptBin "togdnd" ''
        pause_noti () {
          dunstctl close-all
          dunstctl set-paused true
          polybar-msg action dnd module_show
        }

        unpause_noti () {
          dunstctl set-paused false
          polybar-msg action dnd module_hide
        }

        toggle_noti () {
          if [ "$(dunstctl is-paused)" = "true" ]; then
            unpause_noti
          else
            pause_noti
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
  };
}
