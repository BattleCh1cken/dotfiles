{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.tmux;
in
{

  options.modules.cli.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      keyMode = "vi";
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];

      extraConfig = ''

      '';


    };

  };

}
