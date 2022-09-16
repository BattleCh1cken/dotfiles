{ pkgs, system, config, ... }: {

  networking.hostName = "boxie";

  programs.hyprland.enable = true;
  boot.kernelParams = [ "nvme.noacpi=1" ];
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;

    displayManager.lightdm.greeters.mini = {
      enable = false;
      user = "battlechicken";
    };
  };
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
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
    tor-browser-bundle-bin
    blender

    #Steam deps
    gamemode
    libstrangle
    #CLI Tools
    #tailscale
    killall
  ];
  #Why must I suffer
  hardware.video.hidpi.enable = true;
  services.xserver.dpi = 144;
  environment.variables = {
    GDK_SCALE = "2";
    #GDK_DPI_SCALE = "0.5";
  };
  #tailscale stuff
  #networking.firewall.checkReversePath = "loose";
  #services.tailscale.enable = true;


  services.flatpak.enable = true;
  programs.steam.enable = true;
  # virtualisation.docker.enable = true;

  security.pki.certificateFiles = [ "/home/battlechicken/Downloads/ckroot.crt" ];

}
