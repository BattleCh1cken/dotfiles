{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.steam;
in
{
  options.modules.programs.steam = { enable = mkEnableOption "steam"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ steam ];
  };

}
