/*
  The entry point for the module tree.
*/
{ ... }: {
  imports = [
    ./core
    ./hardware
    ./services
    ./shell
  ];

  config = {
    # https://search.nixos.org/options?channel=unstable&show=system.stateVersion
    # defines the version of NixOS that the system was first installed with
    # used for maintaining backwards compatibility, generally shouldn't be changed
    system.stateVersion = "24.05";
  };
}
