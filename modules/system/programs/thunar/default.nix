{ pkgs, system, lib, config, ... }:
with lib;
let cfg = config.modules.programs.thunar;
in
{

  options.modules.programs.thunar = { enable = mkEnableOption "thunar"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xfce.thunar ];
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

  };
} 
