{ pkgs, system, config, ... }: {
  environment.variables = {
    # GDK_SCALE = "2";
  };
  boot.kernelParams = [ "nvme.noacpi=1" ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [

    gnomeExtensions.unite
  ];



  programs.steam.enable = true;
  virtualisation.docker.enable = true;

}
