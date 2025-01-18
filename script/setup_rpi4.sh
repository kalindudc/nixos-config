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

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "${GREEN}Setting up Raspberry Pi 4 with NixOS${NC}"
echo "${GREEN}=====================================${NC}"
echo ""

echo "${GREEN}Updating the firmware...${NC}"
echo " "
nix-shell -p raspberrypi-eeprom --run '
mount /dev/disk/by-label/FIRMWARE /mnt
BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable rpi-eeprom-update -d -a
'
echo " "
echo "${GREEN}Firmware updated successfully!${NC}"
echo " "

echo "${GREEN}Pulling default configuration...${NC}"
echo " "
curl -fSL --progress-bar https://raw.githubusercontent.com/kalindudc/nixos-config/main/host/base/rpi4/init.nix -o /etc/nixos/configuration.nix
echo "${GREEN}Default configuration pulled successfully!${NC}"
echo " "

echo "${GREEN}Rebuilding the system...${NC}"
echo " "
nixos-rebuild switch --upgrade
echo "${GREEN}System rebuilt successfully!${NC}"
echo " "

echo "${GREEN}Setting up nixos-config...${NC}"
echo " "
git clone https://github.com/kalindudc/nixos-config.git

# get device host from user input
echo " "
read -p "${RED}Enter the device host: ${NC}" device_host
echo " "

nixos-install switch --flake "./nixos-config#$device_host"

echo " "
echo "${GREEN}Setup complete! Remember to set a password for your user and the root.${NC}"
echo "  > passwd root"
echo "  > passwd <your-username>"
