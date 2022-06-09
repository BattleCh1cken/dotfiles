{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.bspwm;
in
{
  options.modules.bspwm = {
    enable = mkEnableOption "Bspwm window manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      picom
      polybar
    ];


  };
}
