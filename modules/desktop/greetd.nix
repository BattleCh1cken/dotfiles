{ lib
, pkgs
, config
, ...
}:
# greetd display manager
with lib; let
  cfg = config.modules.desktop.greetd;
in
{
  options.modules.desktop.greetd = {
    enable = mkEnableOption "greetd";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      # settings.default_session.command = "${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.cage} -m last -s -- ${lib.getExe pkgs.greetd.regreet}";
    };
    programs.regreet.enable = true;
    # security.pam.services.greetd.gnupg.enable = true;
  };
}
