{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.gnome;
in
{
  options.modules.desktop.gnome = {
    enable = mkEnableOption "gnome";
    config = mkIf cfg.enable { };
  };
}
