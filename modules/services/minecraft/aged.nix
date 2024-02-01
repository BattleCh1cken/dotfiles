{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.minecraft.aged;
in {
  options.modules.services.minecraft.aged = {
    enable = mkEnableOption "aged";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      "mc-aged" = {
        autoStart = true;
        image = "docker.io/itzg/minecraft-server:latest";
        volumes = [
          "/srv/data/minecraft/aged:/data"
        ];
        ports = ["25565:25565"];
        environment = {
          EULA = "true";
          VERSION = "1.19.2";
          TYPE = "FABRIC";
          FARBIC_LAUNCHER_VERSION = "0.11.2";
          FARBIC_LOADER_VERSION = "0.14.21";
          MOTD = "I cry every time";
          MEMORY = "12G";
          JVM_XX_OPTS = "-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true";
        };
        extraOptions = ["--pull=newer"];
      };
      "mc-aged-backup" = {
        autoStart = true;
        image = "itzg/mc-backup";
        volumes = [
          "/srv/data/minecraft/aged:/data:ro"
          "/srv/data/minecraft/backups/aged:/backups"
        ];
        environment = {
          INITIAL_DELAY = "10m";
          BACKUP_INTERVAL = "30m";
          PRUNE_BACKUPS_DAYS = "7";
          PAUSE_IF_NO_PLAYERS = "true";
        };
        extraOptions = [
          "--pull=newer"
          "--network=container:mc-aged"
        ];
      };
    };
  };
}
