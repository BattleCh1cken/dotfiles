{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/modules.nix
  ];

  config.modules = {
    desktop = {
      bspwm.enable = true;
      eww.enable = true;
      # kde.enable = true;
    };
    programs = {
      firefox.enable = true;
      kitty.enable = true;
      steam.enable = true;
    };
    cli = {
      nvim.enable = false;
      git.enable = true;
      zsh.enable = true;
    };
  };
}
