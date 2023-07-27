{
  lib,
  pkgs,
  config,
  ...
}:
# greetd display manager
with lib; let
  cfg = config.modules.desktop.greetd;
  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://github.com/shaunsingh/nix-darwin-dotfiles/blob/main/configs/wallpapers/train.png?raw=true";
    sha256 = "1krijm5hi6i6cnbdzp4wmxwlxfw3z6x9vsbj2yms2hws6x3mw8lk";
  };
in {
  options.modules.desktop.greetd = {
    enable = mkEnableOption "greetd";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bibata-cursors
    ];

    services.greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.cage} -m last -s -- ${lib.getExe pkgs.greetd.regreet}";
    };
    programs.regreet = {
      enable = true;
      settings = {
        settings = {
          background = {
            path = wallpaper;
            fit = "Cover";
          };
          GTK = {
            cursor_theme_name = "Bibata-Modern-Classic";
          };
        };
      };
    };
    security.pam.services.greetd.gnupg.enable = true;
  };
}
