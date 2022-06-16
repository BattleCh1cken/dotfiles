{ config, lib, inputs, ... }: {
  imports = [
    ../../modules/default.nix
  ];

  options.modules = {
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
