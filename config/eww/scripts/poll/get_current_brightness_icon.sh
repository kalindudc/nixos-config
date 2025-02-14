#!/usr/bin/env bash

brightness=$(( $(brightnessctl get) * 100 / $(brightnessctl max) ))
if (( brightness > 90 )); then
  echo "󰛨"
elif (( brightness > 80 )); then
  echo "󱩕"
elif (( brightness > 60 )); then
  echo "󱩓"
elif (( brightness > 40 )); then
  echo "󱩒"
elif (( brightness > 20 )); then
  echo "󱩐"
else
  echo "󱩎"
fi
