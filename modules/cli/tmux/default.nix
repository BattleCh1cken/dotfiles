{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.tmux;
in
{

  options.modules.cli.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      # shell = "\${pkgs.zsh}/bin/zsh";
      keyMode = "vi";
      extraConfig = "



      ";


    };

  };

}
