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

  modules = {
    shell.zsh.enable = true;
    shell.git.enable = true;
    shell.starship.enable = true;
    editors = {
      default = "nvim";
      neovim.enable = true;
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
  ];

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
