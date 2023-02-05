{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.hyprland;
  configDir = config.dotfiles.configDir;
in
{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  options.modules.desktop.hyprland = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
    programs.hyprland = {
      enable = true;
    };

    services.xserver = {
      displayManager = {
        sddm.enable = true;
        #lightdm.greeters.mini.enable = true;
      };
    };


    environment.systemPackages = with pkgs; [
      waybar
      hyprpaper

      wl-clipboard
    ];

    # link recursively so other modules can link files in their folders
    home.configFile = {
      "hypr" = {
        source = "${configDir}/hyprland/";
        recursive = true;
      };
      "waybar" = {
        source = "${configDir}/waybar/";
        recursive = true;
      };

    };
  };
}
