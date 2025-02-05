#!/usr/bin/env bash

calendar(){
  eww="$(which eww)"

  # Run eww daemon if not running
  if [[ ! `pidof eww` ]]; then
    ${eww} daemon
    sleep 1
  fi

  lock_file="$HOME/.cache/.eww_calendar.lock"
  calendar_is_open=$(${eww} get calendar)
  if [[ $calendar_is_open == true ]]; then
    if [[ ! -f $lock_file ]]; then
      ${eww} open calendar
      touch $lock_file
    fi
  else
    if [[ -f $lock_file ]]; then
      ${eww} close calendar
      rm $lock_file
    fi
  fi
}

calendar
