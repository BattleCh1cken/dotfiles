{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.syncthing;
in {
  options.modules.services.syncthing = {
    enable = mkEnableOption "syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "${config.user.name}";
      dataDir = "/home/${config.user.name}/Documents"; # Default folder for new synced folders
      configDir = "/home/${config.user.name}/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
}
