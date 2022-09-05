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
    firejail
    google-chrome
    aseprite
    qbittorrent
    printrun
    cura
    freecad
    gparted
    #tor-browser-bundle-bin

    #Steam deps
    gamemode
    libstrangle
    #CLI Tools
    tailscale
  ];
  networking.firewall.checkReversePath = "loose";
  services.tailscale.enable = true;


  services.flatpak.enable = true;
  programs.steam.enable = true;
  # virtualisation.docker.enable = true;

}
