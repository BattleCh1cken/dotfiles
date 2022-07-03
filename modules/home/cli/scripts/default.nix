{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.cli.scripts;
  # ide = pkgs.writeShellScriptBin "ide" ''${builtins.readFile ./scripts/ide.sh''  ;
in
{

  options.modules.cli.scripts = { enable = mkEnableOption "scripts"; };

  config = mkIf cfg.enable {

    home.packages = [ ide ];


  };

}



