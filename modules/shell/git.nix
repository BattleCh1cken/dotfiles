{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.shell.git;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.shell.git = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
    ];

    #home.configFile = {
    #"git/config".source = "${configDir}/git/config";
    #"git/ignore".source = "${configDir}/git/ignore";
    #};

  };
}
