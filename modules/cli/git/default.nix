{ pkgs, lib, config, ... }:
with lib;
let cfg = modules.cli.git;
in
{
  modules.cli.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];
  };
}
