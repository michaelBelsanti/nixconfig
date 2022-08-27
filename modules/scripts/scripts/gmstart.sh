#!/usr/bin/env sh

echo 'always' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
# killall picom # I've reached a point in life where I prefer rounded corners to minutely better performance
~/.scripts/togdnd.sh -p
polybar-msg action gamemode module_show
gpu-screen-recorder -w DP-4 -c mp4 -f 60 -a "$(pactl get-default-sink).monitor" -r 45 -o ~/Videos/Replays &
