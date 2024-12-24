{ pkgs
, config
, lib
, inputs # binds to specialArgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd

    inputs.disko.nixosModules.disko
    ./disko-config.nix
  ];
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  modules = {
    hardware = {
      brightness.enable = true;
      touchpad.enable = true;
      audio.enable = true;
    };

  };

  environment.systemPackages = with pkgs; [

  ];
}
