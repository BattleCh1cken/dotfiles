{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd

    inputs.disko.nixosModules.disko
    ./disko-config.nix
  ];

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
      niri = {
        enable = true;

      };

      gtk.enable = true;
      dunst.enable = true;
      ags.enable = true;

      term.default = "kitty";
      term.kitty.enable = true;

      apps = {
        steam.enable = true;
        nautilus.enable = true;
        onagre.enable = true;
        fuzzel.enable = true;
        #qemu.enable = true;
      };
    };

    hardware = {
      audio.enable = true;
      touchpad.enable = true;
    };
    services.syncthing.enable = true;
  };


  environment.systemPackages = with pkgs; [

    #misc
    libsecret

    #Apps
    qbittorrent
    zoom-us
    thunderbird
    firefox
    vesktop
    vlc
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
    obs-studio-plugins.obs-websocket
    obs-studio-plugins.obs-vkcapture
    audacity
    networkmanager-openvpn
    tor-browser-bundle-bin
    inkscape
    libreoffice
    signal-desktop
    godot_4
    (symlinkJoin {
      name = "bambu-studio";
      paths = [ bambu-studio ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/bambu-studio --set GTK_THEME Adwaita:light
      '';
    })
    eog
    monero-gui
    rpi-imager
    putty

    openconnect
    gp-saml-gui

    temurin-jre-bin-11

    #Command line utils
    tailscale
    xdg-utils
    unzip
    zip
    gotop
    htop
    ranger
    protonup
    killall
    wget
    cmatrix
    fd
    xclip
    fastfetch
    acpi
    gh

    radeontop
    libva-utils
    powertop
    fw-ectool
  ];

  services.gnome.gnome-keyring.enable = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  hardware.bluetooth.enable = false;
  services.tlp.enable = false;
  services.tailscale.enable = true;

  #boot.tmp.useTmpfs = true;
  #boot.tmp.tmpfsSize = "95%";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.BROWSER = "zen";

  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = true;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

}
