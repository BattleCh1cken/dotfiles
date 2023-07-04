# Credit to hlissner
# Definetly not stolen
{
  inputs = {
    # Nixpkgs branches
    master.url = "github:nixos/nixpkgs/master";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-23.05";

    # Flake inputs
    home-manager.url = "github:nix-community/home-manager";
    agenix.url = "github:ryantm/agenix";
    hyprland.url = "github:hyprwm/hyprland";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim.url = "/home/battlechicken/Projects/nixvim";
    eww.url = "github:elkowar/eww";
    fred.url = "github:area-53-robotics/discord-bot";

    # Default Nixpkgs for packages and modules
    nixpkgs.follows = "unstable";

    # Minimize duplicate instances of inputs
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    eww.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    stable,
    master,
    ...
  }: let
    inherit (lib.my) mapModules mapModulesRec mapHosts;

    system = "x86_64-linux";

    mkPkgs = pkgs: extraOverlays:
      import pkgs {
        inherit system;
        config.allowUnfree = true; # forgive me Stallman senpai
        overlays = extraOverlays;
      };

    pkgs = mkPkgs nixpkgs [self.overlay];

    pkgs-stable = mkPkgs stable [self.overlay];
    pkgs-master = mkPkgs master [self.overlay];

    lib =
      nixpkgs.lib.extend
      (self: super: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = self;
        };
      });
  in {
    overlay = final: prev: {
      master = pkgs-master;
      stable = pkgs-stable;
      my = self.packages."${system}";
    };

    packages."${system}" =
      mapModules ./pkgs (p: pkgs.callPackage p {});

    nixosConfigurations =
      mapHosts ./hosts {};

    devShell.${system} = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        cachix
        deadnix
      ];
    };

    formatter.${system} = pkgs.alejandra;

    # TODO: move to import
    templates = {
      basic = {
        path = ./templates/basic;
        description = "A very basic flake";
      };
      rust = {
        path = ./templates/rust;
        description = "rust moment";
      };
    };
  };
}
