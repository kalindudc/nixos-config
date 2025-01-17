{ config, pkgs, ... }:

{
  # Bootloader.

  boot.loader.systemd-boot.enable = false;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    theme = pkgs.catppuccin-grub;
    fontSize = 18;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  # Default time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.cron.enable = true;

  services.logind = {
    extraConfig = ''
      HandlePowerKey=suspend
    '';
  };

  services.printing.enable = true;
  services.libinput.enable = true;
  services.fstrim.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # media-session.enable = true;
  };

  # services.xserver.libinput.enable = true;

  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.yazi.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Default packages.
  environment.systemPackages = with pkgs; [
    bc
    btop
    cmake
    curl
    cpio
    dnsutils
    ethtool
    fastfetch
    file
    ffmpeg
    fzf
    gawk
    gcc
    git
    glib
    gnupg
    gnused
    gnutar
    git
    go
    gsettings-qt
    ipcalc
    jq
    killall
    ldns
    libappindicator
    libnotify
    libvirt
    lshw
    lsof
    meson
    mtr
    nix-output-monitor
    neovim
    nmap
    nnn
    openssl
    parted
    pciutils
    pkg-config
    rustup
    stow
    tree
    unzip
    usbutils
    vim
    vscode
    wget
    which
    xdg-user-dirs
    xdg-utils
    xz
    yq-go
    zip
    zstd
    zsh
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    fira-code
    jetbrains-mono
    font-awesome
	  terminus_font
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    montserrat
    roboto
    material-icons
  ];

  virtualisation.docker.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # garbage collection and boot loader menu
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +10";
  };

  nix.settings.auto-optimise-store = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # tl;dr: just don't change it
  system.stateVersion = "24.11";
}
