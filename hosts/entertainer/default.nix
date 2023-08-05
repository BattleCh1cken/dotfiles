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
      greetd.enable = true;
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
      media.ncmpcpp.enable = true;
    };
    shell = {
      zsh.enable = true;
      starship.enable = true;
      git.enable = true;
    };

    editors = {
      default = "nvim";
      nixvim.enable = false;
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

  services.xserver = {
    #displayManager.setupCommands = ''
    #${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --rate 144 --mode 1920x1080 --pos 0x500 --output HDMI-1 --rate 60 --mode 1920x1080 --pos 1920x0 --rotate right
    #'';
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    #misc
    libsecret
    mesa

    #Apps
    firefox
    mailspring
    qbittorrent
    vlc
    gimp
    krita
    obsidian
    freecad
    discord-canary
    google-chrome
    vscode.fhs
    #godot_4
    godot
    prismlauncher
    zoom-us
    super-slicer-latest
    #blender
    #aseprite-unfree
    pavucontrol
    arduino
    inkscape

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
    zathura
  ];

  programs.dconf.enable = true; # TODO: relocate to module

  services.gnome.gnome-keyring.enable = true; # TODO: relocate to module

  services.tailscale.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
