{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.modules.services.ssh;
in
{
  options.modules.services.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.KbdInteractiveAuthentication = false;
      # We don't want to allow password authentication, as key based authentication is much more secure.
      settings.PasswordAuthentication = false;
    };
  };
}
