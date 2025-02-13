#!/usr/bin/env bash

# when -t is passed set $TEST_MODE to true
while getopts "t" opt; do
  case ${opt} in
    t )
      TEST_MODE="true"
      ;;
    \? )
      echo "Usage: cmd [-t]"
      exit 1
      ;;
  esac
done

echo $TEST_MODE > $HOME/.cache/eww_test_mode

test_config_dir="$HOME/src/github.com/kalindudc/nixos-config/config/eww"
eww_binary=$(which eww)

if [[ $TEST_MODE == "true" ]]; then
  echo "$eww_binary -c $test_config_dir"
else
  echo "$eww_binary"
fi
