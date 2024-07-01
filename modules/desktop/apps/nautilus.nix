{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.nautilus;
in
{
  options.modules.desktop.apps.nautilus = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gnome.nautilus

    ];

    services.gvfs.enable = true; # Mount, trash, and other functionalities
  };
}
