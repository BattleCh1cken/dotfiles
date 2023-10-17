{
  lib,
  pkgs,
  config,
  ...
}:
# greetd display manager
with lib; let
  cfg = config.modules.desktop.greetd;
in {
  options.modules.desktop.greetd = {
    enable = mkEnableOption "greetd";
  };

  config = mkIf cfg.enable {
    security.pam.services = {
      login = {
        enableGnomeKeyring = true;
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };

      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };

    services.greetd = {
      enable = true;
    };

    programs.regreet = {
      enable = true;
    };
  };
}
