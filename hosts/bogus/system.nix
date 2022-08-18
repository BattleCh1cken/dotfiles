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

  imports = [ ../../modules/services/minecraft.nix ];
  modules.services.minecraft.enable = true;

}
