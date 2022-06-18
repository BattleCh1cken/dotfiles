{ pkgs, system, config, ... }: {
  networking.hostName = "Entertainer"; # Define your hostname.
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    #Enable KDE Plasma
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;



}
