{ config, pkgs, ...}:
{
  imports = [
    ../../rofi
  ];
  
  xdg.configFile = {
    i3 = {
      source = ./config;
      target = "i3/config";
    };
    picom = {
      source = ./picom.conf;
      target = "picom/picom.conf";
    };
    polybar = {
      source = ./polybar;
      recursive = true;
    };
    dunst = {
      source = ./dunstrc;
      target = "dunst/dunstrc";
    };
  };
  home.packages = with pkgs; [
  (writeScriptBin "togpicom" ''
    pgrep -x picom
    if [ $? -ne 0 ]
    then
        picom --unredir-if-possible --experimental-backends
    else
        pkill picom
    fi;
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
}
