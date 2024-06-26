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
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swayfx

      wl-clipboard
      pulseaudio

      flameshot
      shotman

      grim
      slurp
      swappy

      xdg-desktop-portal
    ];

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
    };

    security = {
      polkit.enable = true;
      pam.services.swaylock = { };
    };

    hardware.opengl.enable = true;

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
