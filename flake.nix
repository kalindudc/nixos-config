{
  description = "@kalindudc nixos-config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ...}: {
    nixosConfigurations.beagle = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./host/base/configuration.nix
        ./host/beagle/configuration.nix 
      ];
    };
  };
}