{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.term.kitty;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.term.kitty = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    home.configFile = {
      "kitty" = { source = "${configDir}/kitty"; recursive = true; };
    };

  };
}