{ config, pkgs, ... }:

{
  home.username = "kalindu";
  home.homeDirectory = "/home/kalindu";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    btop
    delta
    dnsutils
    ethtool
    fastfetch
    file
    fzf
    gawk
    gnupg
    gnused
    gnutar
    ipcalc
    jq
    ldns
    lsof
    mtr
    nix-output-monitor
    nmap
    nnn
    pciutils
    ripgrep
    tree
    unzip
    usbutils
    which
    xz
    yq-go
    zip
    zstd
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Kalindu De Costa";
    userEmail = "kalinduk.decosta@gmail.com";
    aliases = {
      st = "status";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        plus-style = "syntax '#003800'";
	      minus-style = "syntax '#3f0001'";
	      syntax-theme = "Dracula";
        file-decoration-style = "none";
	      hunk-header-decoration-style = "cyan box ul";
      };
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # same as https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}