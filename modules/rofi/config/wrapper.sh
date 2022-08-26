#!/usr/bin/env sh

if getopts rwomc option; then
  case "${option}" in
    r) rofi -show drun -theme ~/.config/rofi/main.rasi ;;
    w) rofi -show window -theme ~/.config/rofi/main.rasi ;;
    o) ~/.config/rofi/options.sh ;;
    m) rofi -show calc -theme ~/.config/rofi/calc.rasi -no-show-match -no-sort -calc-command "echo -n '{result}' | xclip -sel clip" ;;
    c) rofi -modi "clipboard:greenclip print" -theme main -show clipboard -run-command '{cmd}' ;;
  esac
else
  echo "Usage: -r 'runner', -w 'windows', -o 'options menu', -m 'math' -c 'clipboard'"
fi
