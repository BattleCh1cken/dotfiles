/*
  This is a module that wraps the Docker Minecraft Server container
  https://github.com/itzg/docker-minecraft-server
  https://github.com/itzg/docker-mc-backup

  This module doesn't intend to expose every option from those containers,
  it just establishes a reasonable set of defaults and exposes options that I change often,
  making it easy to deploy modded servers quickly.
*/
{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.modules.services.modded-minecraft;
in
{
  options.modules.services.modded-minecraft = {
    enable = lib.mkEnableOption "modded-minecraft";
    name = lib.mkOption {
      type = lib.types.str;
    };

    difficulty = lib.mkOption {
      type = lib.types.str;
      default = "hard";
    };

    type = lib.mkOption {
      type = lib.types.str;
      default = "FABRIC";
    };

    version = lib.mkOption {
      type = lib.types.str;
      default = "1.21.4";
    };


  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.oci-containers.containers = {
      "mc-${cfg.name}" = {
        autoStart = true;
        image = "docker.io/itzg/minecraft-server:latest";
        volumes = [
          "/srv/data/minecraft/${cfg.name}:/data"
        ];
        ports = [ "25565:25565" ];
        environment = {
          EULA = "true";

          VERSION = cfg.version;
          TYPE = cfg.type;

          MOTD = "\u00a75powered by femboys";
          DIFFICULTY = cfg.difficulty;
          ENABLE_WHITELIST = "true";
          ALLOW_FLIGHT = "TRUE";
          PAWN_PROTECTION = "0";
          SNOOPER_ENABLED = "false";
          MEMORY = "12G";
        };

        extraOptions = [ "--pull=alwaye" ];
      };

      "mc-${cfg.name}-backup" = {
        autoStart = true;
        image = "itzg/mc-backup";

        volumes = [
          "/srv/data/minecraft/${cfg.name}:/data:ro"
          "/srv/data/minecraft/backups/${cfg.name}:/backups"
        ];

        environment = {
          INITIAL_DELAY = "10m";
          BACKUP_INTERVAL = "30m";
          PRUNE_BACKUPS_DAYS = "7";
          PAUSE_IF_NO_PLAYERS = "true";
        };

        extraOptions = [
          "--pull=always"
          "--network=container:mc-${cfg.name}"
        ];
      };
    };

    networking.firewall = {
      allowedTCPPorts = [
        25565 # default minecraft port
        24454 # port for proximity voice chat
      ];
      allowedUDPPorts = [
        25565
        24454
      ];
    };
  };
}
