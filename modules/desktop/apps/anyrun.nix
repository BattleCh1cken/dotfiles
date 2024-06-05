{ config
, options
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.anyrun;
in
{
  options.modules.desktop.apps.anyrun = {
    enable = mkEnableOption "anyrun";
  };

  config = mkIf cfg.enable {
    home.config = {
      imports = [
        inputs.anyrun.homeManagerModules.default
      ];

      programs.anyrun = {
        enable = true;

        config = {
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications
            rink
            shell
            symbols
            websearch
          ];

          width.fraction = 0.3;
          y.absolute = 15;
          hidePluginInfo = true;
          closeOnClick = true;
        };

        extraCss = ''
          * {
            transition: 200ms ease;
            font-family: JetBrainsMono Nerd Font;
            font-size: 1.3rem;
          }

          #window,
          #match,
          #entry,
          #plugin,
          #main {
            background: transparent;
          }

          #match:selected {
            background: #b7bdf8;
          }

          #match {
            padding: 3px;
            border-radius: 5px;
          }

          #entry, #plugin:hover {
            border-radius: 16px;
          }

          box#main {
            background: #24273a;
            border: 1px solid #363a4f;
            border-radius: 24px;
            padding: 8px;
          }
        '';
      };
    };
  };
}
