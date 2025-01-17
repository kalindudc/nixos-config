{ inputs, config, pkgs, ... }:

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

  services.xserver.videoDrivers = [ "amdgpu" "modesetting" "fbdev" ];

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

  hardware.graphics = {
    extraPackages = with pkgs; [
      libva
      libva-utils
    ];
  };

  users.users.kalindu = {
    isNormalUser = true;
    description = "Kalindu De Costa";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
  # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
  programs.hyprland = {
    enable = true;

    portalPackage = pkgs.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
    withUWSM = true;
  };

  programs.hyprlock.enable = true;
  programs.firefox.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    configPackages = [
      pkgs.xdg-desktop-portal
    ];
  };

  environment.systemPackages = with pkgs; [
    ansible
    hyprpicker
    hyprlock
    kdePackages.dolphin
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
    kitty
    libsForQt5.qt5ct
    waypaper
    wlogout

    (
      sddm-astronaut.override {
        themeConfig = {
          Background = "${../../config/assets/wallpaper/lock_screen_wallpaper.jpg}";
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
