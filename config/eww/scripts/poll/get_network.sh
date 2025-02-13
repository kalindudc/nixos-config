#!/usr/bin/env bash

connection_type=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')

if [[ "$connection_type" == "wifi" ]]; then
  echo "$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')"
elif [[ "$connection_type" == "ethernet" ]]; then
  echo "$(nmcli -t -f NAME connection show --active | grep ethernet)"
else
  echo "None"
fi
