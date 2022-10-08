{ config, pkgs, ...}:
{
  xdg.configFile."dunst" = {
    source = ./config;
    recursive = true;
  };
  home.packages = with pkgs; [
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
