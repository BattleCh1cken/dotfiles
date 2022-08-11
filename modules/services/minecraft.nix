{ pkgs, lib, system, config, ... }:
with lib;
let cfg = config.modules.services.minecraft;
in
{
  options.modules.services.minecraft = { enable = mkEnableOption "minecraft"; };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      packwiz
      cmake
    ];
    virtualisation.docker.enable = true;

    systemd.services.mcFabric = {
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" "docker.socket" ];
      requires = [ "docker.service" "docker.socket" ];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart =
          ''${pkgs.docker}/bin/docker run \
           -p 25565:25565 -v /home/battlechicken/data/minecraft:/data --name mc \
          -e EULA=true \
          -e TYPE=FABRIC \
          -e VERSION="1.18.2" \
          -e PACKWIZ_URL="https://battlech1cken.github.io/Quilt-Modpack/pack/.minecraft/pack.toml" \
          -e MOTD="powered by imbeciles" \
          --rm itzg/minecraft-server
          '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mc
        '';
        # Restart = "always";
      };
    };
    systemd.services.mc-backup = {
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" "docker.socket" ];
      requires = [ "docker.service" "docker.socket" ];
      serviceConfig = {
        Type = "simple";
        User = "battlechicken";
        ExecStart = ''
          ${pkgs.docker}/bin/docker run \
          --name mc-backup \
          --network container:mc \
          -v /home/battlechicken/data/backups:/data \
          -v /home/battlechicken/data/minecraft \
          -e BACKUP_METHOD="restic" \
          -e INITIAL_DELAY="1m" \
          -e RESTIC_PASSWORD="password" \
          -e RESTIC_REPOSITORY="/home/battlechicken/data/backups" \
          -e PRUNE_RESTIC_RETENTION="--keep-daily 7 --keep-weekly 5" \
          --rm itzg/mc-backup
        '';
        ExecStop = ''
          ${pkgs.docker}/bin/docker stop mc-backup
        '';
        Restart = "always";
      };
    };
    networking.firewall.allowedTCPPorts = [ 25565 ];
    networking.firewall.allowedUDPPorts = [ 25565 ];
  };
}
