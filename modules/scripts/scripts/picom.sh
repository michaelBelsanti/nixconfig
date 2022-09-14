#!/usr/bin/env sh

pgrep -x picom
if [ $? -ne 0 ]
then
    picom --unredir-if-possible --experimental-backends
else
    pkill picom
fi
