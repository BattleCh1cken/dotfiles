{ pkgs, lib, config, fetchzip, inputs, stdenv, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
  };

in
{
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wofi
      swaybg
      brightnessctl
      pamixer
      python39Packages.requests
      sway-contrib.grimshot
      slurp
      tesseract5
      grim
      wlogout
    ];

    home.pointerCursor.package = pkgs.nordzy-cursor-theme;
    home.pointerCursor.name = "Nordzy-cursors";
    home.pointerCursor.size = 16;
    home.pointerCursor.gtk.enable = true;

    home.file.".config/hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };


    #systemd.user.services = {
    #swaybg = mkService {
    #Unit.Description = "Wallpaper chooser";
    #Service.ExecStart =
    #"${pkgs.swaybg}/bin/swaybg -i /home/sioodmy/pics/walls/wall.png";
    #};
  };
}
