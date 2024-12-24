{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disko-config.nix
  ];

  # TODO: things I need for this server to function:
  # - ssh config
  # - modded mc server module

  modules = {
    services = {
      ssh.enable = true;
    };
  };
}
