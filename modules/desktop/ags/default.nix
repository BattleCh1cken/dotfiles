{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib; let
  cfg = config.modules.desktop.ags;
in
{

  options.modules.desktop.ags = {
    enable = mkEnableOption "ags";
  };

  config = mkIf cfg.enable {
    home.config = {
      imports = [ inputs.ags.homeManagerModules.default ];

      programs.ags = {
        enable = true;
        extraPackages = with pkgs; [
          gtksourceview
          webkitgtk
          accountsservice
        ];
      };

    };
  };
}
