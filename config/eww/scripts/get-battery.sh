#!/usr/bin/env bash

battery=$(upower -e | grep 'BAT')
battery_info=$(upower -i $battery)

echo "$battery_info" | grep -E "percentage" | awk '{print $2}' | sed 's/.$//'

