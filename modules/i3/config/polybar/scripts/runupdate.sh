#!/usr/bin/env sh

alacritty -e paru

# Currently commented out because bash always think's paru failed
#if [ $? -eq 0 ]; then 
#	notify-send --app-name=Updates "Updates failed :("
#else
#	notify-send --app-name=Updates "Updates completed!"
#fi

notify-send --app-name=Updates "Update script completed!"

# Used to find wm name, but if you don't 
# switch often you can delete this and hardcode it
wm=$(wmctrl -m | awk 'NR==1{print $2}')

~/.config/polybar/$wm.sh
