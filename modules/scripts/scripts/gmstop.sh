#!/usr/bin/env sh

echo 'madvise' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
# picom --experimental-backends --unredir-if-possible
~/.scripts/togdnd.sh -u
polybar-msg action gamemode module_hide
