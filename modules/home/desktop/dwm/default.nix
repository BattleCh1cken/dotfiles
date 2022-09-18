{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.desktop.dwm;
in
{
  options.modules.desktop.dwm = {
    enable = mkEnableOption "dwm window manager";
  };

  config = mkIf cfg.enable {
    xsession = {
      enable = true;
      windowManager.command = "dwm";
    };
    home.packages = with pkgs; [
      gcc
      #libs
      xorg.libX11
      xorg.libXinerama

      dmenu
      pamixer
      flameshot
      feh
    ];

    home.file.".config/dwm/autostart.sh".source = ./scripts/autostart.sh;
    home.file.".config/dwm/bar.sh".source = ./scripts/bar.sh;
    home.file."Pictures/wallpapers/wallpaper.png".source = ../../../../assets/wallpaper.png;
    home.file."Pictures/wallpapers/wallpaper-tall.png".source = ../../../../assets/wallpaper-tall.png;





  };
}

