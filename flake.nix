{
  description = "@kalindudc nixos-config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ...}: {
    nixosConfigurations.beagle = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./hosts/base/configuration.nix
        ./hosts/beagle/configuration.nix 
      ];
    };
  };
}