{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.qemu;
in {
  options.modules.desktop.apps.qemu = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
    ];

    virtualisation.libvirtd.enable = true;
  };
}
