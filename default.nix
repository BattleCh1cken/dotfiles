{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; {
  imports =
    [inputs.home-manager.nixosModules.home-manager]
    # All my personal modules
    ++ (mapModulesRec' (toString ./modules) import);

  system.configurationRevision = with inputs; mkIf (self ? rev) self.rev;

  system.stateVersion = "21.05"; # TODO: this should be set per host

  ## Some reasonable, global defaults
  # This is here to appease 'nix flake check' for generic hosts with no
  # hardware-configuration.nix or fileSystem config.
  fileSystems."/".device = mkDefault "/dev/disk/by-label/nixos";

  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so we enforce
  # this default behavior here.
  #networking.useDHCP = mkDefault false;
}
