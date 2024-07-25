{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.sway;
in
{
  options.modules.desktop.sway = {
    enable = mkEnableOption "sway";

    extraConfig = mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swayfx

      swww

      wl-clipboard
      pulseaudio
      light
      #networkmanagerapplet


      sway-contrib.grimshot

      xdg-desktop-portal
    ];

    home.configFile."sway/config" = {
      text = lib.strings.concatStrings [
        (builtins.readFile
          ./config)
        "\n"
        cfg.extraConfig
      ];
    };
    home.configFile."wallpaper.png".source = ../../../config/wallpaper.png;

    environment.sessionVariables = {
      # this needs to be here so that the xdg portal doesn't freak out
      # and actually gives us permission to do things
      XDG_CURRENT_DESKTOP = "sway";
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
