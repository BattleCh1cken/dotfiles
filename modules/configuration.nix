{ config, pkgs, lib, ... }:
with lib;
{
  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

  };
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = true;
  time.hardwareClockInLocalTime = true;



  #Create a user
  users.users.battlechicken = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "battlechicken";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];





  system.stateVersion = "22.05"; #Don't Touch
}
