{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
    environment.systemPackages = with pkgs; [
      neovim
      lazygit
      ripgrep
      gcc

      # Language servers
      lua-language-server
      rnix-lsp
      nodePackages_latest.typescript-language-server
    ];
  };
}
