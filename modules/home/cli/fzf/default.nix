{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.fzf;
in
{
  options.modules.cli.fzf = { enable = mkEnableOption "fzf"; };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--preview '([[ -f {} ]] && (bat --style=numbers --theme=base16 --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
        "--color=bg+:#302D41,bg:#1E1E2E,spinner:yellow,hl:red --color=fg:white,header:red,info:magenta,pointer:yellow --color=marker:yellow,fg+:magenta,prompt:magenta,hl+:red,border:bright-black"
      ];
    };
  };
}
