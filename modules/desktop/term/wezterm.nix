{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.term.wezterm;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.term.wezterm = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wezterm
    ];
    home.configFile = {
      "wezterm" = {
        source = "${configDir}/wezterm";
        recursive = true;
      };
    };
  };
}
