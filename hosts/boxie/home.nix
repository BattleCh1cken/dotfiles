{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/home/modules.nix
  ];

  config.modules = {
    desktop = {
      hyprland.enable = true;
    };
    programs = {
      firefox.enable = true;
      kitty.enable = true;
      steam.enable = true;
    };
    cli = {
      nvim.enable = true;
      git.enable = true;
      zsh.enable = true;
      tmux.enable = true;
      scripts.enable = true;
    };
  };
}
