{
  description = "@kalindudc nixos-config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ...}: {
    nixosConfigurations.beagle = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ 
        ./host/base/configuration.nix
        ./host/beagle/configuration.nix 
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "rebuild";
          home-manager.users.kalindu = import ./host/beagle/home.nix;
        }
      ];
    };
  };
}