{ pkgs, system, config, ... }: {
  environment.variables = {
    # GDK_SCALE = "2";
  };
  boot.kernelParams = [ "nvme.noacpi=1" ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    #Install tweaks
    gnome.gnome-tweaks
    gnomeExtensions.unite

    #Drivers
    mesa

    #Apps
    aseprite
    qbittorrent

    #Steam deps
    gamemode
    libstrangle
  ];
  #Android stuff
  programs.adb.enable = true;


  services.flatpak.enable = true;
  programs.steam.enable = true;
  # virtualisation.docker.enable = true;

}
