{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      term.default = "kitty";
      term.kitty.enable = true;
      #awesomewm.enable = true;
      hyprland.enable = true;
      apps.steam.enable = true;
      apps.thunar.enable = true;
      apps.rofi.enable = true;

    };
    shell.zsh.enable = true;
    shell.git.enable = true;
    editors.neovim.enable = true;
    hardware = {
      audio.enable = true;
      touchpad.enable = true;
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
    enable = true;
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
  };
  services.xserver.dpi = 144;
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs;[
    #misc
    libsecret

    #Apps
    firefox
    mailspring
    vlc
    gimp
    obsidian
    discord-canary
    google-chrome
    vscode.fhs
    arduino
    #prismlauncher
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
    acpi
  ];

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
