{ pkgs, ...}:
{
  xdg.configFile = {
    "rofi" = {
      source = ./config;
      recursive = true;
    };
    "greenclip.toml" = {
      text = ''
        [greenclip]
          history_file = "~/.cache/greenclip/greenclip.history"
          max_history_length = 50
          max_selection_size_bytes = 0
          trim_space_from_selection = true
          use_primary_selection_as_input = false
          blacklisted_applications = []
          enable_image_support = true
          image_cache_directory = "~/.cache/greenclip"
          static_history = []
      '';
    };
  };
  
  # Installing scripts to bin
  home.packages = with pkgs; [
    (writeShellScriptBin "rofi-wrapper" ''
      optionsmenu(){
        uptime=$(uptime | awk '{print $1}')
        theme="~/.config/rofi/options.rasi"
        msg_theme="~/.config/rofi/confirm.rasi"
        rofi_command="rofi -theme $theme"
        msg_command="rofi -theme $msg_theme"

        # Options
        shutdown=" shutdown"
        reboot=" reboot"
        logout=" logout"
        suspend="  suspend"
        lock=" lock"

        # Confirmation
        confirm_exit() {
        	echo -e "yes\nno" | $msg_command -dmenu\
        		-p "Are You Sure?"\
        		-theme $msg_theme
        }

        # Variable passed to rofi
        options="$shutdown\n$reboot\n$logout\n$lock\n$suspend"

        chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
        case $chosen in
            $shutdown)
        		ans=$(confirm_exit &)
        		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        			systemctl poweroff
        		fi
                ;;
            $reboot)
        		ans=$(confirm_exit &)
        		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
           		systemctl reboot
        		fi
                ;;
            $lock)
        	    	betterlockscreen --off 30 -l dimblur
                ;;
            $suspend)
        		ans=$(confirm_exit &)
        		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        			systemctl suspend
        		fi
                ;;
            $logout)
        		ans=$(confirm_exit &)
        		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        			pkill Hyprland
        			pkill $(wmctrl -m | awk 'NR == 1 { print $2 }')
        		fi
                ;;
        esac
      }

      if getopts rwomc flag; then
        case "$flag" in
          r) rofi -show drun -theme ~/.config/rofi/main.rasi ;;
          w) rofi -show window -theme ~/.config/rofi/main.rasi ;;
          o) optionsmenu ;;
          m) rofi -show calc -theme ~/.config/rofi/calc.rasi -no-show-match -no-sort -calc-command "echo -n '{result}' | xclip -sel clip" ;;
          c) rofi -modi "clipboard:greenclip print" -theme main -show clipboard -run-command '{cmd}' ;;
        esac
      else
        echo "Usage: -r 'runner', -w 'windows', -o 'options menu', -m 'math' -c 'clipboard'"
      fi
    '')
  ];
}
