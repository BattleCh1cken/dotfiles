{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/modules.nix
  ];

  config.modules = {
    programs = {
      firefox.enable = true;
      kitty.enable = true;
      steam.enable = true;
    };
    cli = {
      nvim.enable = true;
      git.enable = true;
      zsh.enable = true;
    };
    services = {
      dunst.enable = true;
    };
  };
}
