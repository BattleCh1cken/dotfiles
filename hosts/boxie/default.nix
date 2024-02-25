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

  ## Modules
  modules = {
    editors.neovim.enable = true;
    editors.default = "nvim";

    shell.zsh.enable = true;
    shell.starship.enable = true;
    shell.git.enable = true;

    desktop = {
      hyprland = {
        enable = true;
        monitors = [ "monitor=,preferred,auto,1.5" ];
      };
      #greetd.enable = true;
      gtk.enable = true;
      waybar.enable = true;
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
    thunderbird
    firefox
    vlc
    gimp
    (obsidian.override {
      electron = electron_25.overrideAttrs (_: {
        preFixup = "patchelf --add-needed ${libglvnd}/lib/libEGL.so.1 $out/bin/electron"; # NixOS/nixpkgs#272912
        meta.knownVulnerabilities = [ ]; # NixOS/nixpkgs#273611
      });
    })
    discord
    google-chrome
    vscode-fhs
    vscodium-fhs
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
    protonvpn-cli
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

  services.grafana = {
    enable = true;
    settings = {
      date_formats = {
        full_date = "YYYY-MM-DD HH:mm:ss.SSSS";
      };

      server = {
        # Listening Address
        http_addr = "127.0.0.1";
        # and Port
        http_port = 3000;
      };
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1883 ];
  };


}
