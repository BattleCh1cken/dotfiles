{ pkgs, system, config, ... }: {

  networking.hostName = "bogus";


  environment.systemPackages = with pkgs; [

  ];



  #Services

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
    };
  };


  #Docker
  virtualisation.docker.enable = true;

}
