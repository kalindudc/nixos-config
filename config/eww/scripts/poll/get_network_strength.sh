#!/usr/bin/env bash

connection_type=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')

if [[ "$connection_type" == "ethernet" ]]; then
  echo "󰈀"
elif [[ "$connection_type" == "wifi" ]]; then
  strength=$(nmcli -f IN-USE,SIGNAL dev wifi | grep '*' | awk '{print $2}')

  if (( strength > 80 )); then
    echo "󰤨"
  elif (( strength > 60 )); then
    echo "󰤥"
  elif (( strength > 40 )); then
    echo "󰤢"
  elif (( strength > 20 )); then
    echo "󰤟"
  elif (( strength >= 0 )); then
    echo "󰤯"
  else
    echo "󰤭"
  fi
else
  echo "󰤭"
fi

