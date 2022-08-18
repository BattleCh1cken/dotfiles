{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/modules.nix

  ];
  config.modules = {
    cli = {
      zsh.enable = true;
      git.enable = true;
      nvim.enable = true;
    };

  };
}
