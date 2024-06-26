{ pkgs
, lib
, config
, ...
}:
with lib; let
  cfg = config.modules.desktop.swaybg;
in
{
  options.modules.desktop.swaybg = {
    enable = mkEnableOption "swaybg";
  };

  config = mkIf cfg.enable {
    home.config = {
      systemd.user.services.swaybg = {
        Unit = {
          Description = "Wallpaper chooser service";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Install.WantedBy = [ "graphical-session.target" ];
        Service =
          let
            wallpaper = ../../config/wallpaper.png;
          in
          {
            ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${wallpaper}";
            Restart = "always";
          };
      };
    };
  };
}
