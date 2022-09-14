{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/home/modules.nix
  ];

  config.modules = {
    desktop = {
      bspwm.enable = false;
      dwm.enable = true;
      eww.enable = true;
      picom.enable = true;
    };
    programs = {
      firefox.enable = true;
      kitty.enable = true;
      steam.enable = true;
      rofi.enable = true;
      autorandr.enable = true;
    };
    cli = {
      nvim.enable = true;
      git.enable = true;
      zsh.enable = true;
      tmux.enable = true;
      fzf.enable = true;
      scripts.enable = true;
    };
    services = {
      dunst.enable = true;
    };
  };

}
