#!/bin/bash
dmenu_run -p " $(date +'%d.%m.%y %H:%M') $(cat /sys/class/power_supply/BAT0/capacity)% " -fn 'Iosevka-12' # dmenu with patches
