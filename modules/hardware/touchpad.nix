{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.modules.hardware.touchpad;
in
{
  options.modules.hardware.touchpad = {
    enable = lib.mkEnableOption "touchpad";
  };

  config = lib.mkIf cfg.enable {
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
