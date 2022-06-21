{ pkgs, lib, config }:
with lib;
let cfg = config.modules.desktop.eww;
in
{
  options.modules.desktop.eww = { enable = mkEnableOption "eww"; };
  config = mkIf cfg.enable
    {
      programs.eww = {
        enable = true;
      };
    };
} 
