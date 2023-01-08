{ pkgs, config, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.fred.nixosModule
  ];
  modules = {
    services.minecraft.quilt.enable = true;
    shell.zsh.enable = true;
    shell.git.enable = true;
    editors = {
      default = "nvim";
      neovim.enable = true;
    };
  };
  services.fred = {
    enable = true;
    envFilePath = "/home/battlechicken/fred/.env";
    dbFilePath = "/home/battlechicken/fred/bot.db";
  };
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  environment.systemPackages = with pkgs; [
    sqlite
    sqlx-cli
  ];


}
