{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
    let 
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        AmsNix = lib.nixosSystem {
          system = "x86_64-linux"; # Gives Architecture type
          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./configuration.nix
            # Import Specific Thinkpad E14 hardware settings
            nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          ];
        };
      };
    };
}

