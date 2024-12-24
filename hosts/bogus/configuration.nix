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

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";


  # TODO: things I need for this server to function:
  # - ssh config
  # - modded mc server module

  modules = {
    services = {
      ssh.enable = true;
      modded-minecraft = {
        enable = true;
        name = "prominence-ii";
      };

    };
  };

  environment.systemPackages = with pkgs; [
    wget
    mrpack-install
    jdk17
    unzip
  ];
}
