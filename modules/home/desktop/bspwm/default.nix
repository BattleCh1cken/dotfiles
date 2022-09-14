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
      enable = true;
      windowManager.bspwm = {
        enable = true;
        startupPrograms = [
          "xsetroot -cursor_name left_ptr"
          "nitrogen --restore"
          "eww daemon && eww open bar"
        ];
        monitors = {

          "eDP-1" = [ "1" "2" "3" "4" "5" ];
          "DP-2" = [ "1" "2" "3" "4" "5" ];
          "HDMI-0" = [ "6" ];
        };
        settings = {
          window_gap = 10;
          border_width = 0;
        };
        extraConfig = ''

        '';

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
  };
}
