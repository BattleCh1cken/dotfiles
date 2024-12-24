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
    services.openssh.enable = true;
  };
}
