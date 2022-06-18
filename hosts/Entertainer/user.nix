{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ../../modules/modules.nix
  ];

  modules = {
    # programs = {
    # firefox.enable = true;
    # kitty.enable = true;
    # };
    cli = {
      # nvim.enable = true;
      git.enable = true;
    };
  };
}
