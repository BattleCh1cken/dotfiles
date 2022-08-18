{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/home/modules.nix

  ];
  config.modules = {
    cli = {
      zsh.enable = true;
      git.enable = true;
      nvim.enable = true;
    };

  };
}
