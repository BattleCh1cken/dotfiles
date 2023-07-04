{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.greetd;
in {
  options.modules.desktop.greetd = {
    enable = mkEnableOption "greetd";
  };

  config = mkIf cfg.enable {
    services.greetd.enable = true;
    programs.regreet.enable = true;
  };
}
