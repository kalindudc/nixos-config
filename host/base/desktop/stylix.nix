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
        applications = 10;
        terminal = 12;
        desktop = 9;
        popups = 10;
      };
    };
  };
}
