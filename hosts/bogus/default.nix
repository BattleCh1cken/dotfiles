{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    services.minecraft.bepic-create.enable = true;
    shell.zsh.enable = true;
    shell.git.enable = true;
    shell.starship.enable = true;
    editors = {
      default = "nvim";
      nixvim.enable = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  environment.systemPackages = with pkgs; [
    wget
    my.mrpack-install
    jdk17
    unzip
    tailscale
  ];
  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      25565
      24454
    ];
    allowedUDPPorts = [
      25565
      24454
    ];
  };
}
