{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ]; ## Modules
  modules = {
    desktop = {
      sway = {
        enable = true;
        extraConfig = ''
          output DP-1 {
            mode 1920x1080@144.001Hz
            position 0 400
          }

          output HDMI-A-1 {
            mode 1920x1080@75Hz
            transform 90
            position 1920 0
          }

          set $out-left DP-1
          set $out-right HDMI-A-1
          
          workspace 1 output $out-left
          workspace 2 output $out-left
          workspace 3 output $out-left
          workspace 4 output $out-left
          workspace 5 output $out-left
          
          workspace 6 output $out-right
          workspace 7 output $out-right
          workspace 8 output $out-right
          workspace 9 output $out-right
          workspace 0 output $out-right
        '';
      };

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
    signal-desktop
    google-chrome
    vscode.fhs
    google-chrome
    prismlauncher
    zoom-us
    super-slicer-latest
    orca-slicer
    pavucontrol
    inkscape
    libsForQt5.kdenlive
    audacity
    obs-studio
    zathura
    libreoffice
    obsidian
    protonvpn-gui
    bitwarden
    figma-linux
    figma-agent
    aseprite

    #Command line utils
    xdg-utils
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
    my.mrpack-install
    my.rcon-cli
    jdk17
    ventoy
    #spotdl
  ];

  programs.dconf.enable = true; # TODO: relocate to module
  services.gnome.gnome-keyring.enable = true; # TODO: relocate to module

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1883 ];
  };


  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
