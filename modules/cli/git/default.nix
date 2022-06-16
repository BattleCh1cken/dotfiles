{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.git;
in
{
  options.modules.cli.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable { };
}
