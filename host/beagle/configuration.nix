{ config, pkgs, ... }:

let
  screen = {
    width = "1920";
    height = "1200";
  };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "beagle";

  # Set your time zone.
  time.timeZone = "America/Toronto";

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    wayland = {
      enable = true;
      compositor = "weston";
    };
  };

  # Enable the KDE Plasma Desktop Environment, for now...
  services.desktopManager.plasma6.enable = true;
  services.gnome.gnome-keyring.enable = true;

  users.users.kalindu = {
    isNormalUser = true;
    description = "Kalindu De Costa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

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
    wget
    (
      sddm-astronaut.override {
        themeConfig = {
          Background = "${../../theme/wallpaper/lock_screen_wallpaper.jpg}";
          FormPosition = "left";
          ScreenWidth = "${screen.width}";
          ScreenHeight = "${screen.height}";
          MainColor="#343746";
          AccentColor="#F8F8F2";
          placeholderColor="#99999b";
        };
      }
    )
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # tl;dr: just don't change it
  system.stateVersion = "24.11";
}
