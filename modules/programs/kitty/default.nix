{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.kitty;
in
{

  options.modules.programs.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {

    programs.kitty = {
      enable = true;
    };
  };
}
