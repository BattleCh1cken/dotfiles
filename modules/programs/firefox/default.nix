{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.firefox;
in
{
  options.modules.programs.firefox = { enable = mkEnableOption "firefox"; };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };

  };
}
