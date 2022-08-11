{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.desktop.bspwm;
in
{
  options.modules.desktop.bspwm = {
    enable = mkEnableOption "Bspwm window manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nitrogen picom pamixer brightnessctl flameshot ];
    xsession = {
      enable = false;
      windowManager.bspwm = {
        enable = true;
        startupPrograms = [
          "xsetroot -cursor_name left_ptr"
          "nitrogen --restore"
          "eww daemon && eww open bar"
        ];
        monitors = {
          "DP-2" = [ "1" "2" "3" "4" "5" "6" ];
        };
        settings = {
          window_gap = 10;
          border_width = 0;

        };

      };

    };
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + {_,shift + }q" = "bspc node -{c,k}";
        "super + shift + Escape" = "pkill -USR1 -x sxhkd; notify-send 'sxhkd' 'Reloaded config'";
        "super + alt + {q,r}" = "bspc {quit,wm -r}";
        "alt + control + shift + {h,j,k,l}" =
          "e -z {left -30 0 || bspc node -z right -30 0, bottom 0 20 || bspc node -z top 0 30, top 0 -30 || bspc node -z bottom 0 -30, right 30 0 || bspc node -z left 30 0}";
        "super + {_,shift + }minus" = "bspc node -{c,k}";
        "super + m" = "bspc desktop -l next";
        "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
        "super + g" = "bspc node -s biggest.window";
        "super + {t,shift + t,s,f}" =
          "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        "super + ctrl + {m,x,y,z}" =
          "bspc node -g {marked,locked,sticky,private}";
        "super + {_,shift + }{h,j,k,l}" =
          "bspc node -{f,s} {west,south,north,east}";
        "super + {p,b,comma,period}" =
          "bspc node -f @{parent,brother,first,second}";
        "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
        "super + {grave,Tab}" = "bspc {node,desktop} -f last";
        "super + {o,i}" = "bspc wm -h off; bspc wm -h off; bspc wm -h on";
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
        "super + ctrl + space" = "bspc node -p cancel";
        "super + ctrl + shift + space" =
          "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
        "super + alt + {h,j,k,l}" =
          "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {h,j,k,l}" =
          "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        "super + shift + s" = "flameshot gui";

        "XF86AudioRaiseVolume" =
          ''pamixer --increase 5 --unmute && volume &'';
        "XF86AudioLowerVolume" =
          ''pamixer --decrease 5 --unmute && volume &'';
        "XF86AudioMute" =
          ''pamixer --toggle && volume'';
        "XF86MonBrightnessUp" =
          "brightnessctl set +5% && bright &";
        "XF86MonBrightnessDown" =
          "brightnessctl set 5%- && bright &";
      };
    };
    services.picom = {

      package = pkgs.picom;
      enable = true;

      shadow = true;
      shadowOffsets = [ (-12) (-12) ];

      fade = true;
      fadeDelta = 5;

      vSync = true;
      backend = "glx";

      settings = {
        fading = true;
        fade-in-step = "0.02";
        fade-out-step = "0.05";
        corner-radius = 10;
        xinerama-shadow-crop = true;

        shadow-ignore-shaped = false;

        no-fading-openclose = false;
        no-fading-destroyed-argb = true;
        active-opacity = 1.0;
        inactive-opacity = 1.0;
        frame-opacity = 1.0;

        inactive-dim = 0.0;

        glx-no-stencil = false;
        glx-copy-from-front = false;
        use-damage = true;
        detect-rounded-corners = true;
        detect-client-leader = true;
        detect-transient = true;
        unredir-if-possible = true;

        wintypes = {
          tooltip = {
            fade = false;
            full-shadow = false;
            focus = true;
            blur-background = true;
          };
          menu = { full-shadow = true; };
          popup_menu = {
            full-shadow = true;
            fade = true;
            opacity = false;
          };
          utility = { full-shadow = true; };
          toolbar = { full-shadow = true; };
          normal = { full-shadow = true; };
          notification = { full-shadow = true; };
          dialog = { full-shadow = true; };
          dock = { full-shadow = true; };
          dropdown_menu = { full-shadow = true; };
        };

        shadowOpacity = "0.4";
        shadowExclude = [
          "class_g = 'slop'"
          "class_g ?= 'peek'"
          "_NET_WM_WINDOW_TYPE@:a *= 'SPLASH'"
          "window_type = 'utility'"
          "window_type = 'dropdown_menu'"
        ];
        blur-background = true;
        blur-method = "dual_kawase";
        blur-size = 20;
        blur-deviation = 5;
        blur-background-fixed = true;
        blur-background-frame = true;
        blur-kernel = "7x7box";
        ## blur-kernel = "5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
        #
        blur-background-exclude = [
          "class_g ~= 'slop'"
          "class_g = 'spectrwm'"
          "class_g = 'GLava'"
          "_GTK_FRAME_EXTENTS@:c"
          "class_g = 'eww-bar'"
        ];
        shadow-exclude = [ "class_g = 'slop'" ];
        focus-exclude = [
          "class_g ?= 'slop'"
          "name = 'rofi'"
          "class_g ?= 'Steam'"
          "_NET_WM_WINDOW_TYPE@:a *= 'MENU'"
          "window_type *= 'menu'"
          "window_type = 'utility'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
        ];
        rounded-corners-exclude = [
          "window_type = 'menu'"
          "window_type = 'popup_menu'"
          "window_type = 'utility'"
          "class_g = 'eww-bar'"
          "class_g = 'dunst'"
        ];
      };
    };
  };
}
