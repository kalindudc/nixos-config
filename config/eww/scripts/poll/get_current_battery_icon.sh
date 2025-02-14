#!/usr/bin/env bash

battery_percentage=$(upower -i $(upower -e | grep BAT) | grep -E percentage | awk '{print $2}' | sed 's/.$//')
if (( battery_percentage > 80 )); then
  echo ""
elif (( battery_percentage > 60 )); then
  echo ""
elif (( battery_percentage > 40 )); then
  echo ""
elif (( battery_percentage > 20 )); then
  echo ""
elif (( battery_percentage > 6 )); then
  echo ""
else
  echo " $battery_percentage%"
fi
