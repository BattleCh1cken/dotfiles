{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    monitors = mkOption {
      type = with types; listOf string;
      description = "A list of monitors to use, and their config. Needs to be formatted according to the Hyprland monitor config.";
      default = [ "monitor=,preferred,auto,1" ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprpaper

      wl-clipboard
      wlr-randr
      pulseaudio
      dunst

      # Screenshot deps
      grim
      slurp
      swappy
    ];

    home.config = {
      imports = [
        inputs.hyprland.homeManagerModules.default
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        extraConfig = ''
          exec-once = wl-clipboard-history -t
          exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once=/usr/lib/polkit-kde-authentication-agent-1
          # sets xwayland scale
          exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

          exec = hyprpaper
          exec-once = dunst

          $mod = SUPER

          # monitors
          ${builtins.concatStringsSep "\n" cfg.monitors}

          bind = $mod, return, exec, ${config.modules.desktop.term.default}
          bind = $mod, Q, killactive,
          bind = $mod SHIFT, Q, exit,
          bind = $mod, D, exec, rofi -show drun

          bind = SUPER, F, fullscreen,
          bind = SUPER, Space, togglefloating,
          bind = SUPER, P, pseudo, # dwindle
          bind = SUPER, S, togglesplit, # dwindle

          # Focus
          bind = $mod, H, movefocus, l
          bind = $mod, L, movefocus, r
          bind = $mod, K, movefocus, u
          bind = $mod, J, movefocus, d

          # Move
          bind = $mod SHIFT, H, movewindow, l
          bind = $mod SHIFT, L, movewindow, r
          bind = $mod SHIFT, K, movewindow, u
          bind = $mod SHIFT, J, movewindow, d

          # Hotkeys
          bind = $mod SHIFT, s, exec, grim -g "$(slurp)" - | swappy -f - -o ~/Pictures/Screenshots/screenshot$(date +%s).png

          # Volume
          binde=, XF86AudioRaiseVolume, exec, pactl set-sink-volume 0 +5%
          binde=, XF86AudioLowerVolume, exec, pactl set-sink-volume 0 -5%

          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          ${builtins.concatStringsSep "\n" (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in ''
                bind = $mod, ${ws}, workspace, ${toString (x + 1)}
                bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
              ''
            )
            10)}

          general {
              gaps_in = 5
              gaps_out = 5
              border_size = 0

              layout = dwindle
          }

          master {
              # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
              new_is_master = true
          }

          decoration {
            rounding = 8
            multisample_edges = true

            active_opacity = 1.0
            inactive_opacity = 1.0

            blur = true
            blur_size = 3
            blur_passes = 3
            blur_new_optimizations = true

            drop_shadow = true
            shadow_ignore_window = true
            shadow_offset = 2 2
            shadow_range = 4
            shadow_render_power = 2
            col.shadow = 0x66000000

            blurls = gtk-layer-shell
            # blurls = waybar
            blurls = lockscreen
          }
          animations {
            enabled = true
            bezier = overshot, 0.05, 0.9, 0.1, 1.05
            bezier = smoothOut, 0.36, 0, 0.66, -0.56
            bezier = smoothIn, 0.25, 1, 0.5, 1

            animation = windows, 1, 5, overshot, slide
            animation = windowsOut, 1, 4, smoothOut, slide
            animation = windowsMove, 1, 4, default
            animation = border, 1, 10, default
            animation = fade, 1, 10, smoothIn
            animation = fadeDim, 1, 10, smoothIn
            animation = workspaces, 1, 6, default

          }
        '';
      };
    };
  };
}
