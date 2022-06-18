{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.git;
in
{
  options.modules.cli.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pre-commit ];
    programs.git = {
      enable = true;
      userName = "BattleCh1cken";
      userEmail = "BattleCh1cken@Larkov.de";
    };

  };
}
