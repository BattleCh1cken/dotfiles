{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.modules.shell.zsh;
in
{
  options.modules.shell.zsh = {
    enable = mkEnableOption "zsh";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Rewrite it in rust
      eza
      bat
      ripgrep
    ];
    user.shell = pkgs.zsh;
    programs.zsh.enable = true;
    home.config = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };


      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        autocd = true;
        #dotDir = ".config/zsh";
        history = {
          expireDuplicatesFirst = true;
        };

        plugins = [
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
        ];

        shellAliases = {
          grep = "grep --color";
          ip = "ip --color";

          ls = "eza --icons --group-directories-first";
          sl = "ls";
          la = "eza -la";
          tree = "eza --tree --icons";

          c = "clear";
          n = "nvim";
          e = "exit";

          g = "git";
          gs = "git status";

          cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
          rebuild = "sudo nix-store --verify; sudo nixos-rebuild switch --flake '.#'";

        };
      };
    };
  };
}
