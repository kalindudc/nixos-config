{ config, pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    fontSize = 24;

    # Grub themes by: https://github.com/vinceliuice/Elegant-grub2-themes
    theme = pkgs.stdenv.mkDerivation {
      name = "elegant-grub2";
      src = ../../../config/grub;
      installPhase = "cp -r ./ $out";
    };
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
    alsa-utils
    bc
    brightnessctl
    btop
    bzip2
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
    glib
    gnumake
    gnupg
    gnused
    gnutar
    git
    go
    go-task
    gsettings-qt
    inputs.ghostty.packages.${pkgs.system}.default
    ipcalc
    jq
    killall
    ldns
    libappindicator
    libffi
    libnotify
    libvirt
    lsb-release
    lshw
    lsof
    meson
    mtr
    ncurses
    nix-output-monitor
    neovim
    nmap
    nnn
    openssl
    parted
    pciutils
    pkg-config
    python3
    readline
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
    zlib
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
    montserrat
    roboto
    material-icons
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

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
