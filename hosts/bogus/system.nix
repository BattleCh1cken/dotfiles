{ pkgs, system, config, ... }: {

  networking.hostName = "bogus";


  environment.systemPackages = with pkgs; [
    # packwiz
    # docker-compose
  ];



  #Services

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
  #  systemd.services.mcStart = {
  #    wantedBy = [ "multi-user.target" ];
  #    after = [ "network.target" ];
  #    description = "a docker container running a mc server";
  #    serviceConfig = {
  #      Type = "forking";
  #      User = "battlechicken";
  #      ExecStart = ''${pkgs.docker}/bin/docker run  itzg/minecraft-server \
  #      -d -v /home/battlechicken/data/minecraft:/data -e TYPE=QUILT \
  #      -e "PACKWIZ_URL=https://raw.githubusercontent.com/BattleCh1cken/HexMC/main/pack/.minecraft/pack.toml" \
  #      -e "VERSION=1.18.1" \
  #      -e "MOTD=hosted by imbeciles" \
  #      -e "EULA=true" \
  # '';
  #      ExecStop = ''${pkgs.docker}/bin/docker stop mc'';
  #      Restart = "always";
  #    };
  #  };
  #
  #
  #  #Docker
  #  virtualisation.docker.enable = true;

  imports = [ ../../modules/services/minecraft.nix ];
  modules.services.minecraft.enable = true;

}
