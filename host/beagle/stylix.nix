{ config, pkgs, ... }:

{
  imports = [
    ../base/desktop/stylix.nix
  ];

  # individual stylix config for beagle
  stylix.image = "${../../config/assets/wallpaper/wallpaper.jpg}";

  # https://github.com/tinted-theming/base16-schemes/blob/main/tokyo-night-storm.yaml
  stylix.base16Scheme = {
    base00 = "24283B";
    base01 = "16161E";
    base02 = "343A52";
    base03 = "444B6A";
    base04 = "787C99";
    base05 = "A9B1D6";
    base06 = "CBCCD1";
    base07 = "D5D6DB";
    base08 = "C0CAF5";
    base09 = "A9B1D6";
    base0A = "0DB9D7";
    base0B = "9ECE6A";
    base0C = "B4F9F8";
    base0D = "2AC3DE";
    base0E = "BB9AF7";
    base0F = "F7768E";
  };

  stylix.polarity = "dark";
  stylix.opacity.terminal = 0.85;
}
