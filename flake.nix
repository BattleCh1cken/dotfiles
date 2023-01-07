# flake.nix --- the heart of my dotfiles
#
# Credit to hlissner
# Definetly not stolen
#
# Welcome to ground zero. Where the whole flake gets set up and all its modules
# are loaded.

{
  description = "A grossly incandescent nixos config.";

  inputs =
    {
      # Core dependencies.
      nixpkgs.url = "nixpkgs/nixos-unstable"; # primary nixpkgs
      nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable"; # for packages on the edge
      home-manager.url = "github:rycee/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "nixpkgs";

      # Extras
      emacs-overlay.url = "github:nix-community/emacs-overlay";
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      nixos-hardware.url = "github:nixos/nixos-hardware";
      pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
      nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
      fred.url = "github:area-53-robotics/discord-bot";


      # wayland nonsense
      # TODO make a functioning hyprland module
      nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
      nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

      system = "x86_64-linux";

      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true; # forgive me Stallman senpai
        overlays = extraOverlays ++ (lib.attrValues self.overlays);
      };
      pkgs = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [ ];

      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in
    {
      lib = lib.my;

      overlay =
        final: prev: {
          unstable = pkgs';
          my = self.packages."${system}";
        };

      overlays =
        mapModules ./overlays import;

      packages."${system}" =
        mapModules ./packages (p: pkgs.callPackage p { });

      nixosModules =
        { dotfiles = import ./.; } // mapModulesRec ./modules import;

      nixosConfigurations =
        mapHosts ./hosts { };

      #devShell."${system}" =
      #import ./shell.nix { inherit pkgs; };

      devShell.${system} = pkgs.mkShell {
        packages = [ pkgs.nixpkgs-fmt ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };

      checks.${system}.pre-commit-check =
        inputs.pre-commit-hooks.lib.${system}.run {
          src = self;
          hooks.nixpkgs-fmt.enable = true;
          hooks.shellcheck.enable = true;
          hooks.stylua.enable = true;
        };

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
