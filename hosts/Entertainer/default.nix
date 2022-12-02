{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      awesomewm.enable = true;
      term = {
        default = "wezterm";
        wezterm.enable = true;
      };
      apps.steam.enable = true;
      apps.thunar.enable = true;
      media.ncmpcpp.enable = true;
    };
    shell.zsh.enable = true;
    shell.git.enable = true;
    editors = {
      default = "nvim";
      neovim.enable = true;
    };
    hardware = {
      audio.enable = true;
      nvidia.enable = true;
    };
    theme.active = "catppuccin";
  };


  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.xserver = {
    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --rate 144 --mode 1920x1080 --pos 0x500\
       --output HDMI-0 --rate 60 --mode 1920x1080 --rotate right --pos 1920x0
    '';
    enable = true;
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    #misc
    libsecret

    #Apps
    firefox
    brave
    mailspring
    qbittorrent
    vlc
    gimp
    obsidian
    freecad
    virt-manager
    discord-canary
    google-chrome
    vscode.fhs
    cura
    prusa-slicer
    godot
    #prismlauncher
    libreoffice
    zoom-us
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
  ];

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
