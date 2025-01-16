{ config, pkgs, lib, ... }:

let
  userData = {
    username = "kalindu";
    homeDirectory = "/home/kalindu";

    shellDir = "src/github.com/kalindudc/shell";
    shellRepo = "https://github.com/kalindudc/shell.git";
  };
in
{
  home.username = userData.username;
  home.homeDirectory = userData.homeDirectory;
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.activation = {
    # during first setup clone shell
    cloneShellRepo = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" "git" ] ''
      export PATH="${lib.makeBinPath (with pkgs; [ git ])}:$PATH"

      if [ ! -d "${userData.homeDirectory}/${userData.shellDir}" ]; then
        echo "Cloning SHELL repository..."
        run git clone "${userData.shellRepo}" "${userData.homeDirectory}/${userData.shellDir}"
      fi
    '';

    setupShell = lib.hm.dag.entryAfter [ "cloneShellRepo" ] ''
      export PATH="${lib.makeBinPath (with pkgs; [ git ruby stow ])}:$PATH"

      if [ ! -f "${userData.homeDirectory}/.shell_setup_complete" ]; then
        echo "Setting up SHELL..."
        run "${userData.homeDirectory}/${userData.shellDir}/src/setup.sh" --silent
      fi
    '';
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bc
    btop
    delta
    dnsutils
    ethtool
    fastfetch
    file
    fzf
    gawk
    git
    gitleaks
    gh
    ghostty
    gnupg
    gnused
    gnutar
    ipcalc
    jq
    kubectl
    ldns
    lsof
    mtr
    nix-output-monitor
    nmap
    nnn
    obsidian
    pciutils
    pyenv
    ripgrep
    ruby
    stow
    tree
    unzip
    usbutils
    which
    xz
    yq-go
    zip
    zsh
    zstd
  ];

  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.rbenv = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.gpg.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Kalindu De Costa";
    userEmail = "kalinduk.decosta@gmail.com";
    includes = [
      { path = "~/.gitconfig"; }
    ];
    aliases = {
      st = "status";
    };
    extraConfig = {
      commit.gpgsign = true;
      tag.gpgSign = true;
    };
    signing = {
      key = null;
      signByDefault = true;
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
  programs.kitty.enable = true;

  services = {
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 21600;
      maxCacheTtl = 43200;
      enableSshSupport = true;
      enableZshIntegration = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };
  wayland.windowManager.hyprland.systemd.enable = false;

  # same as https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
