{ config
, options
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.onagre;
in
{
  options.modules.desktop.apps.onagre = {
    enable = mkEnableOption "onagre";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;[
      onagre
      pop-launcher
      python3
    ];

    home.configFile."onagre/theme.scss".source = ./theme.scss;
    #home.file.".local/share/pop-launcher/plugins/emojis" = {
    #recursive = true;
    #source = ./emojis;
    #};
  };
}
