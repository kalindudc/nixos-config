{ config, pkgs, ... }:

{
  imports = [
    ../base/stylix.nix
  ];

  # individual stylix config for beagle
  stylix.image = "${../../config/assets/wallpaper/wallpaper.jpg}";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
  stylix.polarity = "dark";
  stylix.opacity.terminal = 0.85;
}
