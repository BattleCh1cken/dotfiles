{
  pkgs,
  lib,
  system,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.minecraft.create-extra;
in {
  options.modules.services.minecraft.create-extra = {
    enable = mkEnableOption "create extra";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers."mc-create-extra" = {
      autoStart = true;
      image = "itzg/minecraft-server";
      volumes = [
        "/srv/data/minecraft/mc-create-extra:/data"
      ];
      ports = ["25565:25565"];
      environment = {
        EULA = "true";
        MODRINTH_PROJECT = "https://modrinth.com/modpack/create-extra";
        VERSION = "1.19.2";
        MODRINTH_VERSION = "xWFqQBjM";
      };
      extraOptions = ["--pull=newer"];
    };
  };
}
