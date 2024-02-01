{
  pkgs,
  lib,
  system,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.minecraft.vanilla;
in {
  options.modules.services.minecraft.vanilla = {
    enable = mkEnableOption "vanilla";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers."mc-vanilla" = {
      autoStart = true;
      image = "docker.io/itzg/minecraft-server:latest";
      volumes = [
        "/srv/data/minecraft/vanilla:/data"
      ];
      ports = ["25565:25565"];
      environment = {
        EULA = "true";
        VERSION = "1.20.1";
      };
      extraOptions = ["--pull=newer"];
    };
  };
}
