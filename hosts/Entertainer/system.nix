{ pkgs, system, config, ... }: {
  imports = [
    ../../modules/system/modules.nix
  ];

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # desktopManager.plasma5.enable = true;
    #windowManager.bspwm.enable = true;
    windowManager.dwm.enable = true;

    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --rate 144 --mode 1920x1080 --pos 0x500\
       --output HDMI-0 --rate 60 --mode 1920x1080 --rotate right --pos 1920x0
    '';
    #displayManager.sddm.enable = true;
    displayManager.lightdm.greeters.gtk = {
      enable = true;
    };
  };
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  environment.systemPackages = with pkgs; [
    #misc
    libsecret
    papirus-icon-theme
    ntfs3g

    #Apps
    mailspring
    qbittorrent
    vlc
    gimp
    obsidian
    freecad
    cura
    virt-manager
    discord
    google-chrome
    vscode.fhs
    prismlauncher
    libreoffice
    #Command line utils
    gotop
    cava
    cmus
    ranger
    protonup
    tailscale
    killall
    wget
    cmatrix
    fd
  ];

  modules.programs.thunar.enable = true;


  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  #steam stuff
  programs.steam = {
    enable = false;
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.canon-cups-ufr2 ];

  #virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
}
