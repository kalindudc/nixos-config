#!/usr/bin/env bash

usage() {
  echo "Usage: power.sh [-p lock,logout,reboot,shutdown,suspend]"
  exit 1
}

WORKING_DIR="$(dirname "$(readlink -f "$0")")"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -p)
      POWER_OPTION=$2
      shift 2
      ;;
    *)
      OTHER_ARGS+=("$1")
      shift
      ;;
  esac
done

# if -m is not passed exit
if [[ -z $POWER_OPTION ]]; then
  usage
fi

eww="$($WORKING_DIR/../get_eww.sh ${OTHER_ARGS[@]})"

case "$POWER_OPTION" in
  "lock")
    hyprlock
    ;;
  "logout")
    hyprctl dispatch exit 0
    ;;
  "reboot")
    systemctl reboot
    ;;
  "shutdown")
    systemctl poweroff
    ;;
  "suspend")
    systemctl suspend
    ;;
  *)
    usage
    ;;
esac

