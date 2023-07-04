{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.rofi;
in {
  options.modules.desktop.apps.rofi = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # link recursively so other modules can link files in its folder
    # home.xdg.configFile."rofi" = {
    #   source = <config/rofi>;
    #   recursive = true;
    # };

    user.packages = with pkgs; [
      #rofi-wayland
      rofi
    ];
  };
}
