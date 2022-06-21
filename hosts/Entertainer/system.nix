{ pkgs, system, config, ... }: {
  networking.hostName = "Entertainer"; # Define your hostname.
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # desktopManager.plasma5.enable = true;
    windowManager.bspwm.enable = true;

    displayManager.defaultSession = "none+bspwm";
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "battlechicken";
    };
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;



  programs.steam = {
    enable = true;
  };

}
