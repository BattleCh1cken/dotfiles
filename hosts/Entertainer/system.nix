{ pkgs, system, config, ... }: {
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    #Enable KDE Plasma
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };


}
