{ pkgs, lib, config, mkTmuxPlugin, ... }:
with lib;
let
  cfg = config.modules.cli.tmux;


  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "catppuccin";
    version = "97183fc51071fa9ff20da6c208c9922ec319b1df";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "${version}";
      hash = "sha256-Gy150PYRsZxpvbw615Ojj150fgbkqESkmLfx7iS6Uko=";
    };
  };
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
        { plugin = catppuccin-tmux; }
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
              thm_bg="#11111b"
        thm_fg="#cdd6f4"
        thm_cyan="#89dceb"
        thm_black="#181825"
        thm_gray="#45475a"
        thm_magenta="#cba6f7"
        thm_pink="#f5c2e7"
        thm_red="#f38ba8"
        thm_green="#a6e3a1"
        thm_yellow="#f9e2af"
        thm_blue="#89b4fa"
        thm_orange="#fab387"
        thm_black4="#585b70"

      '';


    };

  };

}
