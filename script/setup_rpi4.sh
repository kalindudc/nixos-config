#! /usr/bin/env bash

# This script is to setup a Raspberry Pi 4 with NixOS ARRCH64
# https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi.html
#
# This script will use an initial pre-built config to for the inital upgrade
# and then will prompt for a device to apply the final configuration

echo "Setting up Raspberry Pi 4 with NixOS"
echo "====================================="
echo ""

echo "Updating the firmware..."
echo " "
sudo nix-shell -p raspberrypi-eeprom --run '
mount /dev/disk/by-label/FIRMWARE /mnt
BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable rpi-eeprom-update -d -a
'
echo " "
echo "Firmware updated successfully!"
echo " "

echo "Pulling default configuration..."
echo " "
sudo curl -fsSL https://raw.githubusercontent.com/kalindudc/nixos-config/main/host/base/rpi4/init.nix -o /etc/nixos/configuration.nix
echo " "
echo "Default configuration pulled successfully!"

echo "Rebuilding the system..."
echo " "
sudo nixos-rebuild switch
echo " "
echo "System rebuilt successfully!"

echo "Setting up nixos-config..."
echo " "
git clone https://github.com/kalindudc/nixos-config.git

# get device host from user input
read -p "Enter the device host: " device_host
sudo nixos-rebuild switch --flake "nixos-config#$device_host"

echo " "
echo "Setup complete!"
