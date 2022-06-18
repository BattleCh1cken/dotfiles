{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.zsh;
in
{
  options.modules.cli.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ exa ];
    programs.zoxide = {
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
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        c = "clear";
        e = "exit";
        n = "nvim";
        cd = "z";
        sl = "exa --icons --sort type";
        ls = "exa --icons --sort type";
        ll = "exa --icons --long --sort type";
        l = "exa --icons --long --sort type";
        tree = "exa --icons --git -a --tree -s type -I '.git|node_modules|bower_components'";
      };
      initExtra = "
          bindkey '^ ' autosuggest-accept
      ";
    };
  };
}
