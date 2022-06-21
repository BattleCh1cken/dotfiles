{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.kde;
in
{
  options.modules.desktop.kde = {
    enable = mkEnableOption "kde";
    config = mkIf cfg.enable {

      xserver = {
        enable = true;
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      };
    };
  };
}
