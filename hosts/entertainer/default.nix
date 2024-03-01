{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      hyprland = {
        monitors = [
          "monitor=DP-1,highrr 1920x1080, 0x500, 1"
          "monitor=HDMI-A-1, 1920x1080, 1920x0, 1, transform, 3"
        ];
        rules = [
          "workspace = 1, monitor:DP-1"
          "workspace = 2, monitor:DP-1"
          "workspace = 3, monitor:DP-1"
          "workspace = 4, monitor:DP-1"
          "workspace = 5, monitor:DP-1"

          "workspace = 6, monitor:HDMI-A-1"
          "workspace = 7, monitor:HDMI-A-1"
          "workspace = 8, monitor:HDMI-A-1"
          "workspace = 9, monitor:HDMI-A-1"
          "workspace = 10, monitor:HDMI-A-1"
        ];
        enable = true;
      };
      #greetd.enable = true;
      dunst.enable = true;
      waybar.enable = true;
      swaybg.enable = true;
      gtk.enable = true;
      term = {
        default = "kitty";
        kitty.enable = true;
      };
      media.ncmpcpp.enable = true;
      apps = {
        steam.enable = true;
        thunar.enable = true;
        qemu.enable = true;
        anyrun.enable = true;
      };
    };

    shell = {
      zsh.enable = true;
      starship.enable = true;
      git.enable = true;
    };

    editors = {
      default = "nvim";
      neovim.enable = true;
    };

    services = {
      syncthing.enable = true;
      docker.enable = true;
    };

    hardware = {
      audio.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    #misc
    libsecret
    mesa

    #Apps
    firefox
    thunderbird
    qbittorrent
    vlc
    thunderbird
    gimp
    krita
    #obsidian
    freecad
    webcord
    (pkgs.discord.override {
      #remove any overrides that you don't want
      withOpenASAR = true;
      withVencord = true;
    })
    signal-desktop
    google-chrome
    vscode.fhs
    google-chrome
    prismlauncher
    zoom-us
    super-slicer-latest
    pavucontrol
    inkscape
    libsForQt5.kdenlive
    audacity
    obs-studio
    zathura
    libreoffice
    (obsidian.override {
      electron = electron_25.overrideAttrs (_: {
        preFixup = "patchelf --add-needed ${libglvnd}/lib/libEGL.so.1 $out/bin/electron"; # NixOS/nixpkgs#272912
        meta.knownVulnerabilities = [ ]; # NixOS/nixpkgs#273611
      });
    })
    protonvpn-gui

    #Command line utils
    ollama
    gotop
    unzip
    htop
    ranger
    protonup
    killall
    wget
    cmatrix
    fd
    neofetch
    libnotify
    feh
    sshfs
    gh
    avrdude
    my.mrpack-install
    my.rcon-cli
    jdk17
    tailscale
    ventoy
    #spotdl
  ];

  programs.dconf.enable = true; # TODO: relocate to module
  services.gnome.gnome-keyring.enable = true; # TODO: relocate to module

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1883 ];
  };

  services.tailscale.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
