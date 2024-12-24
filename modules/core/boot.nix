/*
  This modules handles all settings related to the bootloader.
*/
{ pkgs, config, lib, ... }: {
  boot.loader = {
    systemd-boot.enable = lib.mkDefault true;
    efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
