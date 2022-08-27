#!/usr/bin/env sh

killall -SIGUSR1 gpu-screen-recorder
if [ $? -eq 0 ]; then
  paplay ~/.config/dunst/saved.ogg
  notify-send --app-name="Replay" 'Instant replay saved!'
fi
