{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
  ];

  # FIXME: when reinstalling this system make sure this ends up as the default /boot instead
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  ## Modules
  modules = {
    editors.neovim.enable = true;
    editors.default = "nvim";

    shell.zsh.enable = true;
    shell.starship.enable = true;
    shell.git.enable = true;

    desktop = {
      sway = {
        enable = true;
        extraConfig = ''
          output eDP-1 {
            mode 2256x1504@144.001Hz
            scale 1.6
          }
        '';
      };

      hyprland = {
        enable = false;
        monitors = [ "monitor=eDP-1,2256x1504,0x0,1.6" ];
      };
      gtk.enable = true;
      swaybg.enable = true;
      dunst.enable = true;

      term.default = "kitty";
      term.kitty.enable = true;

      apps = {
        steam.enable = true;
        thunar.enable = true;
        anyrun.enable = true;
      };
    };

    hardware = {
      audio.enable = true;
      touchpad.enable = true;
    };
    services.syncthing.enable = true;
    services.docker.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    #misc
    libsecret

    #Apps
    qbittorrent
    zoom-us
    thunderbird
    firefox
    vlc
    gimp
    obsidian
    google-chrome
    vscode-fhs
    prismlauncher
    pavucontrol
    gimp
    zathura
    feh
    prusa-slicer
    obs-studio
    networkmanager-openvpn
    tor-browser-bundle-bin
    inkscape
    libreoffice
    signal-desktop

    #Command line utils
    unzip
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
    gh
  ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;


  programs.dconf.enable = true; # Not sure where to put this yet

  systemd.services.wpa_supplicant.environment.OPENSSL_CONF = pkgs.writeText "openssl.cnf" ''
    openssl_conf = openssl_init
    [openssl_init]
    ssl_conf = ssl_sect
    [ssl_sect]
    system_default = system_default_sect
    [system_default_sect]
    Options = UnsafeLegacyRenegotiation
  '';

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "95%";

  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = true;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

}
