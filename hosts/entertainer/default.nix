{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
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
      ags.enable = true;
      gtk.enable = true;
      term = {
        default = "kitty";
        kitty.enable = true;
      };

      media.ncmpcpp.enable = true;

      apps = {
        steam.enable = true;
        nautilus.enable = true;
        qemu.enable = true;
        onagre.enable = true;
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

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  environment.systemPackages = with pkgs; [
    #misc
    libsecret
    mesa

    #Apps
    # TODO: have some kind of firefox module
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { }) # we need to override this so screen sharing is possible
    google-chrome

    thunderbird
    signal-desktop

    qbittorrent
    vlc

    kicad
    gimp
    inkscape
    obs-studio
    zathura
    obsidian

    vscode.fhs
    prismlauncher
    zoom-us

    super-slicer-latest
    orca-slicer


    protonvpn-gui
    protonvpn-cli

    vesktop
    easyeffects

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
    libnotify
    feh
    sshfs
    gh
    my.mrpack-install
    my.rcon-cli
    jdk17
    ventoy
  ];

  # TODO: make a printer module
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1883 ];
  };


  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

}
