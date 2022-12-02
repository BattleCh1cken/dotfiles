{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.media.ncmpcpp;
  configDir = config.dotfiles.configDir;
  username = config.user.name;
in
{
  options.modules.desktop.media.ncmpcpp = {
    enable = mkBoolOpt false;
    # modipy.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (ncmpcpp.override { visualizerSupport = true; })
    ];

    env.NCMPCPP_HOME = "$XDG_CONFIG_HOME/ncmpcpp";

    # Symlink these one at a time because ncmpcpp writes other files to
    # ~/.config/ncmpcpp, so it needs to be writeable.
    home.configFile = {
      "ncmpcpp/config".source = "${configDir}/ncmpcpp/config";
      "ncmpcpp/bindings".source = "${configDir}/ncmpcpp/bindings";
    };
    home-manager.users.${username} = {
      services.mpd = {
        enable = true;
        musicDirectory = "/home/${username}/Music";
        network = {
          listenAddress = "any";
          port = 6600;
        };
        extraConfig = ''
          audio_output {
            type                    "fifo"
            name                    "my_fifo"
            path                    "/tmp/mpd.fifo"
            format                  "44100:16:2"
          }
          audio_output {
            type    "pipewire"
            name    "pipewire"
          }
          auto_update "yes"
        '';
      };
      home.packages = with pkgs; [
        mpc-cli
      ];
    };

  };
}
