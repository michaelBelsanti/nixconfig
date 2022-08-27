#!/usr/bin/env sh

pkill easyeffects
sleep .5
easyeffects --gapplication-service &
sleep .5
# pamixer --source $(pamixer --list-sources | awk '/Blue/ {print $1}') --set-volume 100
