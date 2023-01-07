#I have a catppuccin addiction
{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.theme;
in
{
  config = mkIf (cfg.active == "catppuccin") (mkMerge [
    # Desktop-agnostic configuration
    {
      modules = {
        theme = {
          wallpaper = mkDefault ./config/wallpaper.jpg;
          gtk = {
            theme = "Catppuccin";
            iconTheme = "Papirus";
            cursorTheme = "Catppuccin-Mocchiato-Dark";
          };
          fonts = {
            sans.name = "Fira Sans";
            mono.name = "Fira Code";
          };
          colors = {
            black = "#1e1e2e";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#61bfff";
            magenta = "#cba6f7";
            cyan = "#89dceb";
            silver = "#f5e0dc";
            grey = "#313244";
            brightred = "#f38ba8";
            brightgreen = "#a6e3a1";
            brightyellow = "#f9e2af";
            brightblue = "#74c7ec";
            brightmagenta = "#f5c2e7";
            brightcyan = "#89dceb";
            white = "#cdd6f4";

            types.fg = "#cdd6f4";
            types.panelbg = "#1e1e2e";
            types.border = "#1e1e2e";
          };
        };

        #shell.zsh.rcFiles = [ ./config/zsh/prompt.zsh ];
        #shell.tmux.rcFiles = [ ./config/tmux.conf ];
        #desktop.browsers = {
        #firefox.userChrome = concatMapStringsSep "\n" readFile [
        #./config/firefox/userChrome.css
        #];
        #qutebrowser.userStyles = concatMapStringsSep "\n" readFile
        #(map toCSSFile [
        #./config/qutebrowser/userstyles/monospace-textareas.scss
        #./config/qutebrowser/userstyles/stackoverflow.scss
        #./config/qutebrowser/userstyles/xkcd.scss
        #]);
        #};
      };
    }

    # Desktop (X11) theming
    (mkIf config.services.xserver.enable {
      user.packages = with pkgs; [
        catppuccin-gtk
        catppuccin-folders
        catppuccin-cursors
      ];
      fonts = {
        fonts = with pkgs; [
          fira-code
          fira-code-symbols
          open-sans
          jetbrains-mono
          siji
          font-awesome
        ];
      };

      # Compositor
      services.picom = {
        fade = true;
        fadeDelta = 1;
        fadeSteps = [ 0.01 0.012 ];
        shadow = true;
        shadowOffsets = [ (-10) (-10) ];
        shadowOpacity = 0.52;
        #activeOpacity = "1.00";
        #inactiveOpacity = "0.92";
        settings = {
          shadow-radius = 12;
          blur-background = true;
          # blur-background-frame = true;
          #blur-background-fixed = true;
          blur-kern = "7x7box";
          blur-strength = 420;
        };
      };

      # Login screen theme
      services.xserver.displayManager.lightdm.greeters.mini.extraConfig = ''
        text-color = "${cfg.colors.magenta}"
        password-background-color = "${cfg.colors.black}"
        window-color = "${cfg.colors.types.border}"
        border-color = "${cfg.colors.types.border}"
      '';

      # Other dotfiles
      home.configFile = with config.modules; mkMerge [
        {
          #Sourced from sessionCommands in modules/themes/default.nix
          "xtheme/90-theme".source = ./config/Xresources;

        }
        (mkIf desktop.term.kitty.enable {
          "kitty/extra/catppuccin.conf".source = ./config/kitty/catppuccin.conf;
        })
      ];
    })
  ]);
}
