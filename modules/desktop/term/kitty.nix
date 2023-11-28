{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.term.kitty;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.desktop.term.kitty = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.config = {
      programs.kitty = {
        enable = true;
        extraConfig = ''
          font_family JetBrainsMono Nerd Font
          font_size 12.0
          disable_ligatures never
          shell zsh
          window_padding_width 0
          enable_audio_bell no
          hide_window_decorations yes
          globinclude extra/*.conf
          background_opacity 1.0
          window_padding_width 2

          # oxocarbon theme ported to kitty, https://github.com/hbjydev/oxocarbon-kitty
          # originally made by nyoom, https://github.com/nyoom-engineering/oxocarbon

          foreground #dde1e6
          background #161616
          selection_foreground #f2f4f8
          selection_background #525252

          cursor #f2f4f8
          cursor_text_color #393939

          url_color #ee5396
          url_style single

          active_border_color #ee5396
          inactive_border_color #ff7eb6

          bell_border_color #ee5396

          wayland_titlebar_color system
          macos_titlebar_color system

          active_tab_foreground #161616
          active_tab_background #ee5396
          inactive_tab_foreground #dde1e6
          inactive_tab_background #393939
          tab_bar_background #161616

          color0 #262626
          color8 #393939

          color1 #ff7eb6
          color9 #ff7eb6

          color2  #42be65
          color10 #42be65

          color3  #82cfff
          color11 #82cfff

          color4  #33b1ff
          color12 #33b1ff

          color5  #ee5396
          color13 #ee5396

          color6  #3ddbd9
          color14 #3ddbd9

          color7  #dde1e6
          color15 #ffffff

          # vim:ft=conf

        '';
      };

    };
  };
}
