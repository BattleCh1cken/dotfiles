{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.cli.nvim;
in
{
  options.modules.cli.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      ripgrep
      #nix
      rnix-lsp
      #lua
      sumneko-lua-language-server
      stylua
      #bash
      shellcheck
      nodePackages.bash-language-server
      shfmt
      #Markdown
      nodePackages.markdownlint-cli
    ];
    programs.neovim = {
      # enable = true;
      # package = pkgs.neovim-nightly;

    };
  };
}
