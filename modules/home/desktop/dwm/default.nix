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
      dmenu
      pamixer
      flameshot
      feh
    ];

    home.file.".dwm/autostart.sh".source = ./scripts/autostart.sh;
    home.file.".dwm/bar.sh".source = ./scripts/bar.sh;
    home.file."Pictures/wallpapers/wallpaper.png".source = ../../../../assets/wallpaper.png;
    home.file."Pictures/wallpapers/wallpaper-tall.png".source = ../../../../assets/wallpaper-tall.png;





  };
}

