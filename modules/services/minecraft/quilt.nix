{ pkgs, lib, system, config, ... }:
with lib;
let cfg = config.modules.services.minecraft.quilt;
in
{
  options.modules.services.minecraft.quilt = { enable = mkEnableOption "quilt"; };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 25565 ];
    virtualisation.docker.enable = true;
    #should be in its own options
    systemd.services.mcQuilt = {
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" "docker.socket" ];
      requires = [ "docker.service" "docker.socket" ];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart =
          ''${pkgs.docker}/bin/docker run \
          	-p 25565:25565 -v /home/battlechicken/data/minecraft/quilt:/data --name mcQuilt \
          	-e EULA=true \
          	-e TYPE=QUILT \
          	-e VERSION="1.19.2" \
          	-e PACKWIZ_URL="https://battlech1cken.github.io/Quilt-Modpack/pack/pack.toml" \
          	-e MOTD="powered by imbeciles" \
          	-e MEMORY=6G \
          	-e DIFFICULTY=hard \
            -e ALLOW_FLIGHT=TRUE \
            --rm itzg/minecraft-server
          '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mcQuilt
        '';
        #Restart = "always";
      };
    };
    systemd.services.mcQuiltBackup = {
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" "docker.socket" ];
      requires = [ "quilt.service" "docker.service" "docker.socket" ];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''
            ${pkgs.docker}/bin/docker run \
          	--name quiltBackup \
          	--network container:quilt \
          	-v /home/battlechicken/data/backups/quilt:/backups \
          	-v /home/battlechicken/data/minecraft/quilt:/data:ro \
          	-e INITIAL_DELAY="10m" \
          	-e BACKUP_INTERVAL="2h" \
          	--rm itzg/mc-backup
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mcQuiltBackup
        '';
        Restart = "always";
      };
    };

  };
}
