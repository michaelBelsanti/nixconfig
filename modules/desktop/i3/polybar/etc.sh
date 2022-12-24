#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar etc1 2>&1 | tee -a /tmp/polybar1.log & disown
polybar etc2 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
