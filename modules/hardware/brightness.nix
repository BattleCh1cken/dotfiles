{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.modules.hardware.brightness;
in
{
  options.modules.hardware.brightness = {
    enable = lib.mkEnableOption "brightness";
  };

  config = lib.mkIf cfg.enable {
    programs.light.enable = true;
    users.users.battlechicken.extraGroups = [ "video" ];
  };
}
