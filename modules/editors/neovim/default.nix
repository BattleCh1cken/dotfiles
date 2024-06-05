{ config
, lib
, inputs
, pkgs
, ...
}:
with lib; let
  cfg = config.modules.editors.neovim;
in
{
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
    environment.systemPackages = with pkgs; [
      neovim
      lazygit
      ripgrep
      gcc

      tree-sitter
      nodejs

      # Language servers
      lua-language-server

      ## Typst
      typstyle
      tinymist

      ## Nix
      nil
      nixpkgs-fmt

      ## JS/TS
      nodePackages_latest.typescript-language-server

      ## Rust
      rust-analyzer
      rustfmt
    ];
  };
}
