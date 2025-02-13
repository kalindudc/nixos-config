#!/usr/bin/env bash

usage() {
  echo "Usage: script_runner.sh [-t] [-s script_name]"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t)
      TEST_MODE=true
      shift
      ;;
    -s)
      SCRIPT_NAME="$2"
      shift 2
      ;;
    *)
      OTHER_ARGS+=("$1")
      shift
      ;;
  esac
done

# if -s is not passed exit
if [[ -z $SCRIPT_NAME ]]; then
  usage
fi

scripts_dir="$HOME/.config/eww/scripts"
test_scripts_dir="$HOME/src/github.com/kalindudc/nixos-config/config/eww/scripts"

if [[ $TEST_MODE == "true" ]]; then
  $test_scripts_dir/$SCRIPT_NAME ${OTHER_ARGS[@]} -t
else
  $scripts_dir/$SCRIPT_NAME ${OTHER_ARGS[@]}
fi
