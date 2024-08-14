{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib; let
  cfg = config.modules.desktop.gtk;
  username = config.user.name;
in
{
  options.modules.desktop.gtk = {
    enable = mkEnableOption "gtk";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ magnetic-catppuccin-gtk ];
    home.config = {
      imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

      gtk = {
        enable = true;
        theme = {
          name = "Catppuccin-GTK-Dark";
          package = pkgs.magnetic-catppuccin-gtk;
        };

        catppuccin = {
          #enable = true;
          #flavor = "macchiato";
          #accent = "mauve";
          #size = "standard";
          #tweaks = [ "normal" ];
          icon.enable = true;
          icon.accent = "mauve";
        };
        font.name = "JetBrains Mono Nerd Font";
      };

    };
  };
}
