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
      hyprland.enable = true;
      greetd.enable = true;
      eww.enable = true;
      gtk.enable = true;
      term = {
        default = "wezterm";
        wezterm.enable = true;
      };
      apps = {
        steam.enable = true;
        thunar.enable = true;
        qemu.enable = true;
        rofi.enable = true;
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
      nixvim.enable = true;
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
    htop
    cava
    cmus
    ranger
    protonup
    killall
    wget
    cmatrix
    fd
    xclip
    neofetch
    libnotify
    feh
    sshfs
    gh
    avrdude
  ];

  services.gnome.gnome-keyring.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
