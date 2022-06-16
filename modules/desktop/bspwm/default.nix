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
      polybar
      eww
      rofi
      nitrogen
    ];
    services.xserver.windowManager.bspwm = {
      enable = true;
      configFile = "/etc/nixos/config/bspwm/bspwmrc";
      sxhkd.configFile = "/etc/nixos/config/sxhkd/sxhkdrc";
    };
    # services.picom.enable = true;



  };
}
