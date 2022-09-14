#!/usr/bin/env sh

pgrep scrcpy
if [ $? -ne 0 ]
then
  adb connect 192.168.1.245
  scrcpy
else
  pkill scrcpy
fi