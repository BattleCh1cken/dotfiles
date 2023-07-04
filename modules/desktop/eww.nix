{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.eww;
in {
  options.modules.desktop.eww = {
    enable = mkEnableOption "eww";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.master.legacyPackages.x86_64-linux.eww-wayland
      jaq
      socat
    ];
  };
}
