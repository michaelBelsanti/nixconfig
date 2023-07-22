#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar i3-1 2>&1 | tee -a /tmp/polybar1.log & disown
polybar i3-2 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
