{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.anyrun;
in {
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
            randr
            rink
            shell
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
            background: #be95ff;
          }

          #match {
            padding: 3px;
            border-radius: 5px;
          }

          #entry, #plugin:hover {
            border-radius: 16px;
          }

          box#main {
            background: #262626;
            border: 1px solid #393939;
            border-radius: 24px;
            padding: 8px;
          }
        '';
      };
    };
  };
}
