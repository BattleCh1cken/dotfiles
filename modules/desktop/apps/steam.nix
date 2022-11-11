{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.steam;
in {
  options.modules.desktop.apps.steam = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;

    # better for steam proton games
    systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  };
}
