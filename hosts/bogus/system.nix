{ pkgs, system, config, ... }: {

  networking.hostName = "bogus";


  environment.systemPackages = with pkgs; [
    packwiz
    docker-compose
  ];



  #Services

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
  systemd.services.mcStart = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "start a docker container running a mc server";
    serviceConfig = {
      Type = "forking";
      User = "battlechicken";
      ExecStart = ''${pkgs.docker} start mc'';
      ExecStop = ''${pkgs.docker} stop mc'';
      Restart = "always";
    };
  };


  #Docker
  virtualisation.docker.enable = true;

}
