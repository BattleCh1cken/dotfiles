{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.hyprland;
  configDir = config.dotfiles.configDir;
in
{
  imports = [
    #inputs.hyprland.nixosModules.default
  ];

  options.modules.desktop.hyprland = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    #wayland.windowManager.hyprland = {
    #enable = true;
    #};
    environment.systemPackages = with pkgs; [

    ];

    # link recursively so other modules can link files in their folders
    home.configFile = {
      "hyprland/" = {
        source = "${configDir}/hyprland/";
        recursive = true;
      };
    };
  };
}
