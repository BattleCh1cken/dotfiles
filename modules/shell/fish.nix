{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = {
    enable = mkEnableOption "fish";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bat
      exa
      fd
      fzf
      ripgrep
      tldr
      zoxide
      direnv
    ];

    home.config = {
      programs.fish = {
        enable = true;
      };
    };
  };
}
