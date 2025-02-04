{
  description = "@kalindudc nixos-config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    stylix.url = "github:danth/stylix";
    swww.url = "github:LGFae/swww";
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ghostty,
    stylix,
    ...
  }:
  let
    homeManagerBackupExtension = "hm-backup";
  in
  {
    nixosConfigurations.beagle = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit homeManagerBackupExtension;
      };
      modules = [
        ./host/base/desktop/configuration.nix
        ./host/beagle/configuration.nix
        stylix.nixosModules.stylix ./host/beagle/stylix.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "${homeManagerBackupExtension}";
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit homeManagerBackupExtension;
          };
          home-manager.sharedModules = [{
            stylix.targets.gtk.enable = false;
            stylix.targets.waybar.enable = false;
            stylix.targets.rofi.enable = false;
          }];
          home-manager.users.kalindu = import ./host/beagle/home.nix;
        }
      ];
    };

    nixosConfigurations.dns2 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./host/base/rpi4/configuration.nix
        ./host/dns2/configuration.nix
      ];
    };
  };
}
