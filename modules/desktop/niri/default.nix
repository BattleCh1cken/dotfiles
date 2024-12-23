{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.niri;
in
{
  options.modules.desktop.niri = {
    enable = mkEnableOption "niri";

    extraConfig = mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      niri

      swww

      wl-clipboard
      pulseaudio
      brightnessctl
      light
      networkmanagerapplet

      xdg-desktop-portal

      xwayland
      xorg.xauth
    ];

    home.configFile."niri/config.kdl" = {
      text = lib.strings.concatStrings [
        (builtins.readFile
          ./config.kdl)
        "\n"
        cfg.extraConfig
      ];
    };
    home.configFile."wallpaper.png".source = ../../../config/wallpaper.png;

    environment.sessionVariables = {
      # this needs to be here so that the xdg portal doesn't freak out
      # and actually gives us permission to do things
      #XDG_CURRENT_DESKTOP = "niri";
    };

    security = {
      polkit.enable = true;
      pam.services.swaylock = { };
    };

    hardware.graphics.enable = true;

    programs = {
      dconf.enable = true;
      xwayland.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      config.common = {
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];

        "org.freedesktop.impl.portal.FileChooser" = [
          "gtk"
        ];

        default = "wlr";
      };
    };

  };
}
