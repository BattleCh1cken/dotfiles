{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.kitty;
in
{

  options.modules.programs.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {

    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      settings = {
        enable_audio_bell = false;
        shell = "zsh";
        font_family = "JetBrainsMono Nerd Font";
        hide_window_decorations = "yes";
      };
    };


    services.sxhkd.keybindings = {
      "super + Return" = "kitty --single-instance";
    };
    programs.zsh.shellAliases = { ssh = "kitty +kitten ssh"; };

  };

}
