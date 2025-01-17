{ config, pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 11;
        terminal = 13;
        desktop = 10;
        popups = 11;
      };
    };
    targets.grub.enable = false;
  };
}
