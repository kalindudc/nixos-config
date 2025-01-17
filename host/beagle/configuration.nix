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

  # boot.loader.grub = {
  #   enable = true;
  #   device = "/dev/disk/by-id/eui.e8238fa6bf530001001b448b4c041047-part1";
  #   efiSupport = true;
  #   useOSProber = true;
  # };

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
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  environment.systemPackages = with pkgs; [
    cmake
    cpio
    ffmpeg
    git
    glib
    gsettings-qt
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
    killall
    kitty
    libappindicator
    libnotify
    libsForQt5.qt5ct
    meson
    neovim
    openssl
    parted
    pkg-config
    vim
    vscode
    wlogout
    wget
    xdg-user-dirs
    xdg-utils

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

  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
	  terminus_font
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # tl;dr: just don't change it
  system.stateVersion = "24.11";
}
