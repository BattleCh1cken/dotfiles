{ pkgs, lib, config, inputs, ... }:
with lib;
let cfg = config.modules.desktop.hyprland;
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;

  };

}
