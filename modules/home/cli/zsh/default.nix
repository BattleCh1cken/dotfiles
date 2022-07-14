{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.zsh;
in
{
  options.modules.cli.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ exa bat ]; # for swallowing

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        scan_timeout = 5;
        character = {
          error_symbol = "[](bold red)";
          success_symbol = "[](bold green)";
          vicmd_symbol = "[](bold yellow)";
          format = "$symbol [|](bold bright-black) ";
        };
        git_commit = { commit_hash_length = 4; };
        line_break.disabled = false;
        lua.symbol = "[](blue) ";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };
      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      sessionVariables = {
        LC_ALL = "en_US.UTF-8";

        LF_ICONS = import ./LF_ICONS.nix;
      };
      completionInit = ''
        autoload -U compinit
        zstyle ':completion:*' menu select
        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -v '^?' backward-delete-char
      '';
      initExtra = ''
        autoload -U url-quote-magic
        zle -N self-insert url-quote-magic
      '';
      history = {
        save = 1000;
        size = 1000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      shellAliases = {
        rebuild = "sudo nix-store --verify; sudo nixos-rebuild switch --flake .#";
        cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
        need = "nix-shell -p";

        c = "clear";
        e = "exit";

        cat = "bat --style=plain";
        grep = "rg";
        m = "mkdir -p";
        ls = "exa --icons --group-directories-first";
        sl = "ls";
        tree = "exa --tree --icons";
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";

        # Git aliases
        g = "git";
        gs = "git status";
        gc = "git commit -m";
        gp = "git push";
        ga = "git add";

      };

      plugins = with pkgs; [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
    };
  };
}
