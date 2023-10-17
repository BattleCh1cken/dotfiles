{
  pkgs,
  config,
  lib,
  inputs,
  ...
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
        default = "wezterm";
        wezterm.enable = true;
      };
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
<<<<<<< HEAD
=======
    thunderbird
>>>>>>> 182b326 (Format: formatted with Alejandra)
    qbittorrent
    vlc
    thunderbird
    gimp
    krita
    obsidian
    freecad
    webcord
<<<<<<< HEAD
    (pkgs.discord.override {
      #remove any overrides that you don't want
      withOpenASAR = true;
      withVencord = true;
    })
    google-chrome
    vscode.fhs
=======
    google-chrome
    vscode.fhs
    godot_4
>>>>>>> 182b326 (Format: formatted with Alejandra)
    prismlauncher
    zoom-us
    super-slicer-latest
    pavucontrol
    inkscape
    libsForQt5.kdenlive
    obs-studio
    zathura

    #Command line utils
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
    jdk8
    tailscale
    ventoy
    spotdl
  ];

  programs.dconf.enable = true; # TODO: relocate to module
  services.gnome.gnome-keyring.enable = true; # TODO: relocate to module

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
      };
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = ["pattern readwrite #"];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [1883];
  };

  services.tailscale.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
