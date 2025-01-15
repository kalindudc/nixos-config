# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.hostName = "beagle";

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.gnome.gnome-keyring.enable = true;

  programs.firefox.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
    vscode
  ];

  system.stateVersion = "24.11";
}
