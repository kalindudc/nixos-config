{ config, pkgs, lib, homeManagerBackupExtension, ... }:

let
  userData = {
    username = "kalindu";
    homeDirectory = "/home/kalindu";

    # all the dotfiles
    shellDir = "src/github.com/kalindudc/shell";
    shellRepo = "https://github.com/kalindudc/shell.git";
  };
in
{
  imports = [
    ../../config/rofi.nix
    ../../config/wlogout.nix
  ];

  home.username = userData.username;
  home.homeDirectory = userData.homeDirectory;
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.activation = {
    # clone and setup dotfiles
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

  home.file = {
    # wlogout icons
    ".config/wlogout/icon".source = "${../../config/assets/wlogout}";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    delta
    gitleaks
    gh
    kubectl
    nodePackages_latest.pnpm
    nodePackages_latest.yarn
    nodePackages_latest.nodejs
    obsidian
    pyenv
    ripgrep
    ruby
    zsh
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

  services.gnome-keyring.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 21600;
    maxCacheTtl = 43200;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  # icons
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  services.hypridle = {
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # same as https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
