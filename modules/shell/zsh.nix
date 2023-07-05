{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = {
    enable = mkEnableOption "zsh";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Rewrite it in rust
      exa
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
        dotDir = ".config/zsh";
        history = {
          expireDuplicatesFirst = true;
        };

        initExtra = ''
          # run programs that are not in PATH with comma
          command_not_found_handler() {
            ${pkgs.comma}/bin/comma "$@"
          }
        '';

        shellAliases = {
          grep = "grep --color";
          ip = "ip --color";

          ls = "exa --icons --group-directories-first";
          sl = "ls";
          la = "exa -la";
          tree = "exa --tree --icons";

          c = "clear";
          n = "nvim";
          e = "exit";
          g = "git";
          cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
          rebuild = "sudo nix-store --verify; sudo nixos-rebuild switch --flake '.#'";
        };
      };
    };
  };
}
