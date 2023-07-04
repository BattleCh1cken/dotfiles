{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
  configDir = config.dotfiles.configDir;
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      hyprpaper

      wl-clipboard
      wlr-randr
      pulseaudio
      dunst

      # Screenshot deps
      grim
      slurp
      swappy
    ];

    home.configFile = {
      "hypr" = {
        source = "${configDir}/hyprland/";
        recursive = true;
      };
    };
  };
}
