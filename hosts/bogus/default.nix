{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  modules = {
    #services.minecraft.quilt.enable = true;
    shell.zsh.enable = true;
    shell.git.enable = true;
    editors = {
      default = "nvim";
      neovim.enable = true;
    };
  };

  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    #permitRootLogin = "yes";
  };
}
