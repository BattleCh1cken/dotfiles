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
          -e ENABLE_RCON="true" \
          -e RCON_PORT="28016" \
          --rm itzg/minecraft-server
        '';
        ExecStop = ''${pkgs.docker}/bin/docker stop mc'';
        # Restart = "always";
      };
    };
    networking.firewall.allowedTCPPorts = [ 25565 ];
    networking.firewall.allowedUDPPorts = [ 25565 ];
  };
}
