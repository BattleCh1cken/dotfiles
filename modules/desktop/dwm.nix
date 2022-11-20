{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.dwm;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.desktop.dwm = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        dwm = prev.dwm.overrideAttrs (old: { src = ../../config/dwm; });
      })

    ];

    environment.systemPackages = with pkgs; [
      gcc
      #libs
      xorg.libX11
      xorg.libXinerama

      dmenu
      pamixer
      feh

      dunst
      libnotify
    ];

    services = {
      picom.enable = true;
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+dwm";
          lightdm.enable = true;
          lightdm.greeters.gtk.enable = true;
        };
        windowManager.dwm.enable = true;
      };
    };

    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };

    # link recursively so other modules can link files in their folders
    home.configFile = {
      #"picom/picom.conf".source = "${configDir}/picom/picom.conf";
      "dwm" = {
        source = "${configDir}/dwm/scripts";
        recursive = true;
      };
    };
  };
}
