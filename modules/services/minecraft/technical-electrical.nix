{
  pkgs,
  lib,
  system,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.minecraft.technical-electrical;
in {
  options.modules.services.minecraft.technical-electrical = {
    enable = mkEnableOption "lost era modpack";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers."mc-technical-electrical" = {
      autoStart = true;
      image = "docker.io/itzg/minecraft-server:latest";
      volumes = [
        "/srv/data/minecraft/technical-electrical:/data"
      ];
      ports = ["25565:25565"];
      environment = {
        EULA = "true";
        MODRINTH_PROJECT = "https://modrinth.com/modpack/technical-electrical";
        VERSION = "1.19.2";
        MODRINTH_VERSION = "ggs5MFal";
      };
      extraOptions = ["--pull=newer"];
    };
  };
}
