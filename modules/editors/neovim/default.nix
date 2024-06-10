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
      typstyle # Typst
      tinymist
      nil # Nix
      nixpkgs-fmt
      nodePackages_latest.typescript-language-server # JS/TS
      rust-analyzer # Rust
      rustfmt
      stylua # Lua
      black # Python
      nodePackages_latest.prettier # Markdown + misc
    ];
  };
}
