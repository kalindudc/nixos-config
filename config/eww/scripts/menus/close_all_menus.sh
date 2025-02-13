#!/usr/bin/env bash

while [[ $# -gt 0 ]]; do
  case "$1" in
    -e)
      MENU_TO_EXCLUDE=$2
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

if [[ -z $MENU_TO_EXCLUDE ]]; then
  MENU_TO_EXCLUDE=""
fi

# Define the exclusion list
EXCLUSION_LIST=("bar" $MENU_TO_EXCLUDE)

# Get the active window names
ACTIVE_WINDOWS=$($eww active-windows | awk -F: '{print $1}')

# Loop through each window name and check against the exclusion list
for window in $ACTIVE_WINDOWS; do
  if [[ ! " ${EXCLUSION_LIST[@]} " =~ " ${window} " ]]; then
    $eww close $window
  fi
done
