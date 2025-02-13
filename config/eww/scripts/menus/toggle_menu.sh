#!/usr/bin/env bash

usage() {
  echo "Usage: toggle_menu.sh [-m menu_name]"
  exit 1
}

WORKING_DIR="$(dirname "$(readlink -f "$0")")"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -m)
      MENU_NAME=$2
      shift 2
      ;;
    *)
      OTHER_ARGS+=("$1")
      shift
      ;;
  esac
done

# if -m is not passed exit
if [[ -z $MENU_NAME ]]; then
  usage
fi

eww="$($WORKING_DIR/../get_eww.sh ${OTHER_ARGS[@]})"

$WORKING_DIR/close_all_menus.sh ${OTHER_ARGS[@]} -e $MENU_NAME
$eww open --toggle $MENU_NAME

