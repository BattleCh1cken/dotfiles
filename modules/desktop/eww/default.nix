{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.eww;
in
{
  options.modules.desktop.eww = { enable = mkEnableOption "eww"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ eww libcanberra-gtk3 brightnessctl playerctl ];
  };
} 
