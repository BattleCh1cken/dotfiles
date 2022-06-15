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
      rofi
      nitrogen
    ];
    services.xserver.windowManager.bspwm = {
      enable = true;
      configFile = "/etc/nixos/users/battlechicken/config/bspwm/bspwmrc";
      sxhkd.configFile = "/etc/nixos/users/battlechicken/config/sxhkd/sxhkdrc";
    };



  };
}
