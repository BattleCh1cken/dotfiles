{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.kitty;
in
{

  options.modules.programs.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {

    programs.kitty = {
      enable = true;
      theme = "Catppuccin";
      settings = {
        enable_audio_bell = false;
        shell = "zsh";
        font_family = "JetBrainsMono Nerd Font";
        hide_windows_decorations = "yes";
        wayland_titlebar_color = "system";
      };

    };
  };
}
