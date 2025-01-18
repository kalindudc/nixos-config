{ config, pkgs, lib, ... }:

let
  user = "administrator";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    docker
    git
    htop
    wget
    curl
    jq
    dnsutils
    ethtool
    fastfetch
    ffmpeg
    go
    ldns
    nmap
    nnn
    openssl
    pciutils
    stow
    tree
    unzip
    usbutils
    which
    zip
    zsh
  ];

  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQKtsLdrIm6DwN/duRSq8mh51lp/Gjj7WK6GftM97oFk8OYlO5Y5ekqbgQj+JySphjD5V4jRR0yPc7RFJPo+88yb9a8ovC4lOtb13OCzFF4D5c1nx8+P1bwdovxLaAO71CXaNe7riU655RvFcOIouiebf5HMJW/OZZk412qSRT0nf6cpHGBmJ83h/ril7K42pefrqm7x+KE8f1rRhhNx4kh8OcfWWVdpmM/YJAf5qusq1fNOnKBreMMsyQdtk5FQLPZoCBxmHwdvPTEmXgYq+bqEDxIs2fQdx4Fxkrz29LD9lctHz+0e2Rzt/uG6YYf8uQMPiiAwo8ES9O5rndvnqqpcKE3OWlh1Mni2AzR0f12Lmvjo4dYclk9eeLNMbOL/eKJu9p0iLPznGty0ZEWZ8rCpYArPJ/74HjXmY3AbacUDIAWFk36CO6vHKhl8W5rIceiEL3U9Ngf8VlIF/yMKy0CSlHpVNFHWJKAvGO/pRVJPAtzmbithc8NSWOM0+jiOc= kalindu"
      ];
    };
  };

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
