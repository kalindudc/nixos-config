#! /usr/bin/env bash

# This script is to setup a Raspberry Pi 4 with NixOS ARRCH64
# https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi.html
#
# This script will use an initial pre-built config to for the inital upgrade
# and then will prompt for a device to apply the final configuration
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  echo "Start a sudo shel and re-run this script: sudo -i"
  exit 1
fi

echo "Setting up Raspberry Pi 4 with NixOS"
echo "====================================="
echo ""

echo "Updating the firmware..."
echo " "
nix-shell -p raspberrypi-eeprom --run '
mount /dev/disk/by-label/FIRMWARE /mnt
BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable rpi-eeprom-update -d -a
'
echo " "
echo "Firmware updated successfully!"
echo " "

echo "Pulling default configuration..."
echo " "
curl -fSL --progress-bar https://raw.githubusercontent.com/kalindudc/nixos-config/main/host/base/rpi4/init.nix -o /etc/nixos/configuration.nix
echo " "
echo "Default configuration pulled successfully!"

echo "Rebuilding the system..."
echo " "
nixos-rebuild switch --upgrade
echo " "
echo "System rebuilt successfully!"

echo "Setting up nixos-config..."
echo " "
git clone https://github.com/kalindudc/nixos-config.git

# get device host from user input
read -p "Enter the device host: " device_host
nixos-rebuild switch --flake "./nixos-config#$device_host"

echo " "
echo "Setup complete! Remember to set a password for your user."
