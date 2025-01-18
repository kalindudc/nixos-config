{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  swapDevices = [ { device = "/swapfile"; size = 4096; } ];

  networking.useDHCP = lib.mkDefault true;

  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
