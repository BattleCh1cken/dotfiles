{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework
  ];

  ## Modules
  modules = {
    editors.nixvim.enable = true;

    shell.zsh.enable = true;
    shell.starship.enable = true;
    shell.git.enable = true;

    desktop = {
      hyprland = {
        enable = true;
        monitors = [ "monitor=,preferred,auto,1.5" ];
      };
      greetd.enable = true;
      gtk.enable = true;
      waybar.enable = true;

      term.default = "wezterm";
      term.wezterm.enable = true;
      term.kitty.enable = true;

      apps = {
        steam.enable = true;
        thunar.enable = true;
        rofi.enable = true;
      };
    };

    hardware = {
      audio.enable = true;
      touchpad.enable = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    #misc
    libsecret

    #Apps
    mailspring
    firefox
    vlc
    gimp
    obsidian
    discord
    google-chrome
    vscodium-fhs
    prismlauncher
    pavucontrol
    gimp
    zathura

    #Command line utils
    gotop
    htop
    cava
    ranger
    protonup
    killall
    wget
    cmatrix
    fd
    xclip
    neofetch
    acpi
  ];

  programs.dconf.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # XCURSOR_SIZE = "32";
    # GDK_SCALE = "2";
    #GDK_DPI_SCALE = "0.5";
    #_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
