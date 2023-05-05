{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
}
