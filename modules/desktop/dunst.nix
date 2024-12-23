{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib; let
  cfg = config.modules.desktop.dunst;
in
{
  options.modules.desktop.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf cfg.enable {
    home.config = {
      services.dunst = {
        enable = true;

        settings = {
          global = {
            alignment = "center";
            corner_radius = 16;
            follow = "mouse";
            font = "Roboto 10";
            format = "<b>%s</b>\\n%b";
            frame_width = 1;
            offset = "5x5";
            horizontal_padding = 8;
            icon_position = "left";
            indicate_hidden = "yes";
            markup = "yes";
            max_icon_size = 64;
            mouse_left_click = "do_action";
            mouse_middle_click = "close_all";
            mouse_right_click = "close_current";
            padding = 8;
            plain_text = "no";
            separator_color = "auto";
            separator_height = 1;
            show_indicators = false;
            shrink = "no";
            word_wrap = "yes";
          };

          fullscreen_delay_everything = { fullscreen = "delay"; };

          urgency_critical = {
            background = "#161616";
            foreground = "#ffffff";
            frame_color = "#ee5396";
          };
          urgency_low = {
            background = "#161616";
            foreground = "#ffffff";
            frame_color = "#33b1ff";
          };
          urgency_normal = {
            background = "#161616";
            foreground = "#ffffff";
            frame_color = "#42be65";
          };
        };
      };
    };
  };
}
