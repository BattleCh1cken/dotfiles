/*
  This is the entry point for the whole configuration.
  This file does the following things:
  - Defines all of the flakes inputs.
  - Defines all of the hosts
*/
{
  inputs = {
    master.url = "github:nixos/nixpkgs/master";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-23.05";

    nixpkgs.follows = "unstable";

    # allows us to declaratively manage our disks
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # hardware specific configs
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";

    # faster nix implementation
    lix.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
    lix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , lix
    , ...
    }@inputs:
    let
      inherit (self) outputs;

      # TODO: initialize overlays
      # - I don't want to give up having access to stable and master, I need to figure out how to overlay that into nixpkgs.

      default-modules = [
        ./modules

        lix.nixosModules.default
      ];

    in
    {
      # API reference for nixosSystem (ofc its source code, nobody ever documents anything around here)
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/eval-config.nix
      nixosConfigurations = {
        boxie = nixpkgs.lib.nixosSystem {
          # https://nixos-modules.nix.みんな/lessons/function-arguments/lesson/
          specialArgs = { inherit inputs outputs; }; # passed into each of the configuration's modules
          modules = [ ./hosts/boxie/configuration.nix ] ++ default-modules;
          system = "x86_64-linux";
        };

        bogus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/bogus/configuration.nix ] ++ default-modules;
          system = "x86_64-linux";
        };
      };
    };
}
