{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.hardware.touchpad;
in
{
  options.modules.hardware.touchpad = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        clickMethod = "clickfinger";
        sendEventsMode = "enabled";
      };
    };
    environment.systemPackages = with pkgs; [
      libinput
    ];
  };
}
