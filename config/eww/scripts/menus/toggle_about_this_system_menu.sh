#!/usr/bin/env bash

usage() {
  echo "Usage: toggle_about_this_system_menu.sh [-m menu_name]"
  exit 1
}

WORKING_DIR="$(dirname "$(readlink -f "$0")")"

while [[ $# -gt 0 ]]; do
  case "$1" in
    *)
      OTHER_ARGS+=("$1")
      shift
      ;;
  esac
done

eww="$($WORKING_DIR/../get_eww.sh ${OTHER_ARGS[@]})"

$WORKING_DIR/close_all_menus.sh ${OTHER_ARGS[@]}
fastfetch_output=$(fastfetch --logo none --color 0)

echo "fastfetch_output: $fastfetch_output"
$eww update fastfetch_output="$(fastfetch --logo none)"
$eww open --toggle about_this_system

