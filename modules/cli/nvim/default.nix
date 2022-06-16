{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.cli.nvim;
in
{
  options.modules.cli.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;

    };
  };
}
