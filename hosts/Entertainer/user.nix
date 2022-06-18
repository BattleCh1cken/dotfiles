{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/modules.nix
  ];

  config.modules = {
    programs = {
      firefox.enable = true;
      kitty.enable = true;
    };
    cli = {
      nvim.enable = false;
      git.enable = true;
      zsh.enable = true;
    };
  };
}
