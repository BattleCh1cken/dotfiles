{
  pkgs,
  lib,
  system,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.minecraft.fabric;
in {
  options.modules.services.minecraft.fabric = {enable = mkEnableOption "fabric";};

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [25565];
    virtualisation.docker.enable = true;
    #should be in its own options
    systemd.services.mcFabric = {
      wantedBy = ["multi-user.target"];
      after = ["docker.service" "docker.socket"];
      requires = ["docker.service" "docker.socket"];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''          ${pkgs.docker}/bin/docker run \
                    	-p 25565:25565 -v /home/battlechicken/data/minecraft/fabric:/data --name mcFabric \
                    	-e EULA=true \
                    	-e TYPE=FABRIC \
                    	-e VERSION="1.19.2" \
                    	-e MOTD="powered by imbeciles" \
                    	-e MEMORY=8G \
                    	-e DIFFICULTY=hard \
                      -e ALLOW_FLIGHT=TRUE \
                      --rm itzg/minecraft-server
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mcFabric
        '';
        #Restart = "always";
      };
    };
    systemd.services.mcFabricBackup = {
      wantedBy = ["multi-user.target"];
      after = ["docker.service" "docker.socket"];
      requires = ["fabric.service" "docker.service" "docker.socket"];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''
           ${pkgs.docker}/bin/docker run \
          --name mcFabricBackup \
          --network container:mcFabric \
          -v /home/battlechicken/data/backups/fabric:/backups \
          -v /home/battlechicken/data/minecraft/fabric:/data:ro \
          -e INITIAL_DELAY="10m" \
          -e BACKUP_INTERVAL="2h" \
          --rm itzg/mc-backup
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mcFabricBackup
        '';
        Restart = "always";
      };
    };
  };
}
