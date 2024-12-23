{ config
, options
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.fuzzel;
in
{
  options.modules.desktop.apps.fuzzel = {
    enable = mkEnableOption "fuzzel";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;[
      fuzzel
      bemoji
      clipman
      libqalculate
    ];

    home.configFile."fuzzel/fuzzel.ini".source = ./fuzzel.ini;


  };
}
