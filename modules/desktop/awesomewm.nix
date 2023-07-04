{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.awesomewm;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.awesomewm = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services = {
      picom.enable = true;
      xserver = {
        enable = true;
        displayManager = {
          sddm.enable = true;
        };
        windowManager.awesome = {
          package = pkgs.awesome;
          enable = true;
          luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
            luadbi-mysql # Database abstraction layer
          ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
      pulseaudio
      light
      redshift
    ];
    home.configFile = {
      "awesome" = {
        source = "${configDir}/awesome";
        recursive = true;
      };
    };
  };
}
