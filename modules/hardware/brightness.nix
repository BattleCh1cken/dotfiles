{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.hardware.brightness;
in
{
  options.modules.hardware.brightness = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.light.enable = true;
    user.extraGroups = [ "video" ];
  };
}
