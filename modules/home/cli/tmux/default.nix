{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.tmux;
in
{

  options.modules.cli.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-b";
      keyMode = "vi";
      escapeTime = 0;
      plugins = with pkgs; [
        # tmux-plugins.tmux-thumbs
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '0' # minutes
          '';
        }
      ];

      extraConfig = ''

      '';


    };

  };

}
