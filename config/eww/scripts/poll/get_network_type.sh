#!/usr/bin/env bash

connection_type=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')

echo $connection_type
