#!/usr/bin/env bash

length_in_microseconds=$(playerctl metadata --format "{{mpris:length}}")
new_pos=$(echo "scale=2; ($1 / 100) * ($length_in_microseconds / 1000000)" | bc -l | awk '{printf "%.2f\n", $0}')

# Set the player position to the calculated value
playerctl position "$new_pos"
