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

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim.url = "github:BattleCh1cken/nixvim";

    eww.url = "github:elkowar/eww";
    fred.url = "github:area-53-robotics/discord-bot";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    anyrun.url = "github:Kirottu/anyrun";
    ags.url = "github:Aylur/ags";
    disko.url = "github:nix-community/disko";

    # Default Nixpkgs for packages and modules
    nixpkgs.follows = "unstable";

    # Minimize duplicate instances of inputs
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    eww.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    nix.inputs.nixpkgs.follows = "nixpkgs";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , stable
    , master
    , ...
    }:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

      system = "x86_64-linux";

      mkPkgs = pkgs: extraOverlays:
        import pkgs {
          inherit system;
          config.allowUnfree = true; # forgive me Stallman senpai
          overlays = extraOverlays;
        };

      pkgs = mkPkgs nixpkgs [ self.overlay ];

      pkgs-stable = mkPkgs stable [ self.overlay ];
      pkgs-master = mkPkgs master [ self.overlay ];

      lib =
        nixpkgs.lib.extend
          (self: super: {
            my = import ./lib {
              inherit pkgs inputs;
              lib = self;
            };
          });
    in
    {
      overlay = final: prev: {
        master = pkgs-master;
        stable = pkgs-stable;
        my = self.packages."${system}";
      };

      # Export packages for other flakes to use
      packages."${system}" =
        mapModules ./pkgs (p: pkgs.callPackage p { });

      nixosConfigurations =
        mapHosts ./hosts { };

      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          nixpkgs-fmt
          cachix
          deadnix
        ];
      };

      formatter.${system} = pkgs.nixpkgs-fmt;

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
