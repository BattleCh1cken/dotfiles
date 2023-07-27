{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.swaybg;
in {
  options.modules.desktop.swaybg = {
    enable = mkEnableOption "swaybg";
  };

  config = mkIf cfg.enable {
    home.config = {
      systemd.user.services.swaybg = {
        Unit = {
          Description = "Wallpaper chooser service";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Install.WantedBy = ["graphical-session.target"];
        Service = let
          wallpaper = builtins.fetchurl rec {
            name = "wallpaper-${sha256}.png";
            url = "https://github.com/shaunsingh/nix-darwin-dotfiles/blob/main/configs/wallpapers/train.png?raw=true";
            sha256 = "1krijm5hi6i6cnbdzp4wmxwlxfw3z6x9vsbj2yms2hws6x3mw8lk";
          };
        in {
          ExecStart = "${lib.getExe pkgs.swaybg} -i ${wallpaper}";
          Restart = "always";
        };
      };
    };
  };
}
