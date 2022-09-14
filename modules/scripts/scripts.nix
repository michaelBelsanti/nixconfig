  # Script for saving instant replay
  writeScriptBin = {
    name = "replay";
    text = ''
      killall -SIGUSR1 gpu-screen-recorder
      if [ $? -eq 0 ]; then
        paplay ~/.config/dunst/saved.ogg
        notify-send --app-name="Replay" 'Instant replay saved!'
      fi
    '';
  };
  
  # Script run when gamemode starts
  writeScriptBin = {
    name = "gmstart";
    text = ''
      echo 'always' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
      # killall picom # I've reached a point in life where I prefer rounded corners to minutely better performance
      ~/.scripts/togdnd.sh -p
      polybar-msg action gamemode module_show
      gpu-screen-recorder -w DP-4 -c mp4 -f 60 -a "$(pactl get-default-sink).monitor" -r 45 -o ~/Videos/Replays &
    '';
  };
  
  # Script run when gamemode end
  writeScriptBin = {
    name = "gmstop";
    text = ''
      echo 'madvise' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
      # picom --experimental-backends --unredir-if-possible
      ~/.scripts/togdnd.sh -u
      polybar-msg action gamemode module_hide
    '';
  };
  
  # Script to quickly toggle picom
  writeScriptBin = {
    name = "togpicom";
    text = ''
      pgrep -x picom
      if [ $? -ne 0 ]
      then
          picom --unredir-if-possible --experimental-backends
      else
          pkill picom
      fi;
    '';
  };
  
  # Script used to toggle whether dunst is paused, as well as enabling the polybar dnd module
  writeScriptBin = {
    name = "togdnd";
    text = ''
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

      if getopts tpu flag; then
        case "${flag}" in 
          t) toggle_noti exit;;
          p) pause_noti exit;;
          u) unpause_noti exit;;
        esac
      else
        echo "Usage: -p 'pause', -u 'unpause' -t 'toggle'"
      fi
    '';
  };
  
  # Restarts easyeffects, used when it breaks
  writeScriptBin = {
    name = "eerestart";
    text = ''
      pkill easyeffects
      sleep .5
      easyeffects --gapplication-service &
      sleep .5
    '';
  };
  
  # Script to start scrcpy, a tool that streams your phone to your screen (only works on my home network)
  writeScriptBin = {
    name = "ezscrcpy";
    text = ''
      pgrep scrcpy
      if [ $? -ne 0 ]
      then
        adb connect 192.168.1.245
        scrcpy
      else
        pkill scrcpy
      fi    
  '';
  };
