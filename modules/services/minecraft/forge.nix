{
  pkgs,
  lib,
  system,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.minecraft.forge;
in {
  options.modules.services.minecraft.forge = {enable = mkEnableOption "forge";};

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [25565];
    virtualisation.docker.enable = true;
    #should be in its own options
    systemd.services.mcForge = {
      wantedBy = ["multi-user.target"];
      after = ["docker.service" "docker.socket"];
      requires = ["docker.service" "docker.socket"];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''          ${pkgs.docker}/bin/docker run \
                    	-p 25565:25565 -v /home/battlechicken/data/minecraft/mcForge:/data --name mcForge \
                    	-e EULA=true \
                    	-e TYPE=FORGE \
                    	-e VERSION="1.18.2" \
                    	-e MOTD="powered by imbeciles" \
                    	-e MEMORY=6G \
                    	-e DIFFICULTY=hard \
                      -e ALLOW_FLIGHT=TRUE \
                      --rm itzg/minecraft-server
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mcForge
        '';
        #Restart = "always";
      };
    };
    systemd.services.mcForgeBackup = {
      wantedBy = ["multi-user.target"];
      after = ["docker.service" "docker.socket"];
      requires = ["mcForge.service" "docker.service" "docker.socket"];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''
           ${pkgs.docker}/bin/docker run \
          --name mcForgeBackup \
          --network container:mcForge \
          -v /home/battlechicken/data/backups/mcForge:/backups \
          -v /home/battlechicken/data/minecraft/mcForge:/data:ro \
          -e INITIAL_DELAY="10m" \
          -e BACKUP_INTERVAL="2h" \
          --rm itzg/mc-backup
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mcForgeBackup
        '';
        Restart = "always";
      };
    };
  };
}
