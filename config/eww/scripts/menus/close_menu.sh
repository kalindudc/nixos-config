#!/usr/bin/env bash

while [[ $# -gt 0 ]]; do
  case "$1" in
    -m)
      MENU=$2
      shift 2
      ;;
    *)
      OTHER_ARGS+=("$1")
      shift
      ;;
  esac
done

WORKING_DIR="$(dirname "$(readlink -f "$0")")"

eww="$($WORKING_DIR/../get_eww.sh ${OTHER_ARGS[@]})"

if [[ -z $MENU ]]; then
  MENU=""
fi

# Get the active window names
ACTIVE_WINDOWS=$($eww active-windows | awk -F: '{print $1}')
echo "active windows: $ACTIVE_WINDOWS"

# Loop through each window name and check against the exclusion list
for window in $ACTIVE_WINDOWS; do
  echo "matching $MENU with $window"
  if [[ " $MENU " == " ${window} " ]]; then
    $eww close $window
  fi
done
