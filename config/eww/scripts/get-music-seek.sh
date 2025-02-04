#!/usr/bin/env bash

# if no player is running, exit
if ! playerctl -a metadata > /dev/null 2>&1; then
  echo "0"
  exit 0
fi

# Get the current position of the song in seconds
progress_in_seconds=$(playerctl -a position)
length_in_microseconds=$(playerctl -a metadata --format "{{mpris:length}}")

# Output the percentage
echo "scale=2; ($progress_in_seconds * 100) / ($length_in_microseconds / 1000000)" | bc -l | awk '{printf "%.2f\n", $0}'
