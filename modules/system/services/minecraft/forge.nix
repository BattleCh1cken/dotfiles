{ pkgs, lib, system, config, ... }:
with lib;
let cfg = config.modules.services.minecraft.mcForge;
in
{
  options.modules.services.minecraft.mcForge = {
    enable = mkEnableOption "mcForge";
  };

  config = cfg.mcForge.enable {
    networking.firewall.allowedTCPPorts = [ 25565 ];
    virtualisation.docker.enable = true;
    #should be in its own options
    systemd.services.mcForge = {
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" "docker.socket" ];
      requires = [ "docker.service" "docker.socket" ];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart =
          ''${pkgs.docker}/bin/docker run \
           -p 25565:25565 -v /home/battlechicken/data/minecraft/mcForge:/mcForge --name mc \
          -e EULA=true \
          -e PACKWIZ_URL="https://battlech1cken.github.io/forge-modpack/pack/pack.toml" \
          -e MOTD="powered by imbeciles" \
          --rm itzg/minecraft-server
          '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mc
        '';
        #Restart = "always";
      };
    };
    systemd.services.mcForgeBackup = {
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" "docker.socket" ];
      requires = [ "mcFabric.service" "docker.service" "docker.socket" ];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''
          ${pkgs.docker}/bin/docker run \
          --name mc-backup \
          --network container:mc \
          -v /home/battlechicken/data/backups/mcForge:/mcForgeBackups \
          -v /home/battlechicken/data/minecraft/mcForge:ro \
          -e INITIAL_DELAY="1m" \
          -e BACKUP_INTERVAL="2h"\
          --rm itzg/mc-backup
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mc-backup
        '';
        Restart = "always";
      };
    };

  };
}
