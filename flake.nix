{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url= "github:nix-community/home-manager/master";
    #home.manager.inputs.nixpkgs.follows= "nixpkgs";
    };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        AmsNix = lib.nixosSystem {
          inherit system; # Gives Architecture type
          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./configuration.nix
            # Import Specific Thinkpad E14 hardware settings
            nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          ];
        };
      };
      homeConfigurations = {
        amsn = home-manager.lib.homeManagerConfiguration{
          inherit pkgs;
          modules = [
            ./home.nix
          ];
        };
      };
    };
}

