#!/usr/bin/env sh

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

if getopts rwomc option; then
  case "${option}" in
    r) rofi -show drun -theme ~/.config/rofi/main.rasi ;;
    w) rofi -show window -theme ~/.config/rofi/main.rasi ;;
    o) optionsmenu ;;
    m) rofi -show calc -theme ~/.config/rofi/calc.rasi -no-show-match -no-sort -calc-command "echo -n '{result}' | xclip -sel clip" ;;
    c) rofi -modi "clipboard:greenclip print" -theme main -show clipboard -run-command '{cmd}' ;;
  esac
else
  echo "Usage: -r 'runner', -w 'windows', -o 'options menu', -m 'math' -c 'clipboard'"
fi
