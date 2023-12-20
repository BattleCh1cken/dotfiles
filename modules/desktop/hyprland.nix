{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    monitors = mkOption {
      type = with types; listOf str;
      description = "A list of monitors to use, and their config. Needs to be formatted according to the Hyprland monitor config.";
      default = [ "monitor=,preferred,auto,1" ];
    };
    # TODO: find a better way to do this
    rules = mkOption {
      type = with types; listOf str;
      default = [ "" ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wlr-randr
      pulseaudio
      dunst

      networkmanagerapplet

      # Screenshot deps
      grim
      slurp
      swappy
    ];


    home.config = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        extraConfig = ''
          exec-once = wl-clipboard-history -t
          exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

          # sets xwayland scale

          exec-once = waybar
          exec-once = nm-applet

          $mod = SUPER

          # monitors
          ${builtins.concatStringsSep "\n" cfg.monitors}

          bindm=SUPER,mouse:272,movewindow

          bind = $mod, return, exec, ${config.modules.desktop.term.default}
          bind = $mod, Q, killactive,
          bind = $mod SHIFT, Q, exit,
          bind = $mod, D, exec, anyrun

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
          bind = $mod SHIFT, s, exec, grim -g "$(slurp -w 0)" - | swappy -f - -o ~/Pictures/Screenshots/screenshot$(date +%s).png

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
              new_is_master = true
          }

          decoration {
            rounding = 8

            active_opacity = 1.0
            inactive_opacity = 1.0




            drop_shadow = true
            shadow_ignore_window = true
          }

          # unscale XWayland
          xwayland {
            force_zero_scaling = true
          }
          
          # toolkit-specific scale
          env = GDK_SCALE,2
          env = XCURSOR_SIZE,32

          ${builtins.concatStringsSep "\n" cfg.rules}

          xwayland {
            force_zero_scaling = true
          }

        '';
      };
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      config.common.default = "*";
    };
  };
}
