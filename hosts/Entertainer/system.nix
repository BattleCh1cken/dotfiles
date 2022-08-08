{ pkgs, system, config, ... }: {

  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking.hostName = "Entertainer"; # Define your hostname.
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # desktopManager.plasma5.enable = true;
    windowManager.bspwm.enable = true;

    # displayManager.defaultSession = "none+bspwm";
    # displayManager.sddm.enable = true;
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "battlechicken";
    };
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  environment.systemPackages = with pkgs; [
    qbittorrent
    gnome.nautilus
    qt5ct
    vscode
    qmk-udev-rules
    libsecret
    #Apps
    mailspring
    vlc
    gimp

  ];

  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  programs.steam = {
    enable = true;
  };

}
