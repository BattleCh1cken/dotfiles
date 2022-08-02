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
      neovide
      ripgrep
      xclip
      #nix
      rnix-lsp
      #lua
      sumneko-lua-language-server
      stylua
      #bash
      shellcheck
      nodePackages.bash-language-server
      shfmt
    ];
    programs.neovim = {
      # enable = true;
      # package = pkgs.neovim-nightly;

    };
    programs.zsh.shellAliases = {
      # n = "neovide --maximized --multigrid";
      n = "nvim";
    };
    home.file.".config/nvim/" = {
      recursive = true;
      source = ./.;
    };

  };
}
