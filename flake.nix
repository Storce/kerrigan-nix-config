{
  description = "My NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      my-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./hardware-configuration.nix
	  ./website.nix
          ./configuration.nix
        ];
      };
    };
  };
}

