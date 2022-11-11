{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.thunar;
in
{
  options.modules.desktop.apps.thunar = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xfce.thunar ];
    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

  };
}
