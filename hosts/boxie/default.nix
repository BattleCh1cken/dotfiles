{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      term.default = "kitty";
      term.kitty.enable = true;
      hyprland.enable = true;

      apps.firefox.enable = true;
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
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    #misc
    libsecret

    #Apps
    mailspring
    vlc
    gimp
    obsidian
    discord
    google-chrome
    vscode.fhs
    vscodium-fhs
    signal-desktop
    prismlauncher
    pavucontrol
    protonvpn-cli
    tor-browser-bundle-bin
    audacity
    gimp
    #Command line utils
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
    # Drivers etc
    intel-media-driver
    intel-gpu-tools
  ];
  services.xserver.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # bigger tty fonts
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  services.xserver.dpi = 200;
  environment.variables = {
    XCURSOR_SIZE = "32";
    GDK_SCALE = "2";
    #GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
