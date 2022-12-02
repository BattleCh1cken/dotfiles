{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.shell.zsh;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.shell.zsh = {
    enable = mkBoolOpt false;
  };
  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.zsh;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      # I init completion myself, because enableGlobalCompInit initializes it
      # too soon, which means commands initialized later in my config won't get
      # completion, and running compinit twice is slow.
      enableGlobalCompInit = false;
      promptInit = ''
        eval "$(zoxide init zsh)"
        eval "$(starship init zsh)"
        eval "$(direnv hook zsh)"
      '';
    };


    environment.systemPackages = with pkgs; [
      zsh
      nix-zsh-completions
      bat
      exa
      fasd
      fd
      fzf
      jq
      ripgrep
      tldr
      starship
      zoxide
      direnv
    ];

    env = {
      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
      ZSH_CACHE = "$XDG_CACHE_HOME/zsh";
      ZGEN_DIR = "$XDG_DATA_HOME/zgenom";
    };

    home.configFile = {
      #Write it recursively so other modules can write files to it
      "zsh" = { source = "${configDir}/zsh"; recursive = true; };
      "starship.toml" = { source = "${configDir}/starship.toml"; };

    };

  };
}
