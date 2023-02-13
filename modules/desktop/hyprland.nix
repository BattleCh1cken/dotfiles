{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.hyprland;
  configDir = config.dotfiles.configDir;
in
{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  options.modules.desktop.hyprland = {
    enable = mkBoolOpt false;
    nvidia = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];

    programs.hyprland = {
      enable = true;
      nvidiaPatches = if cfg.nvidia then true else false;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };



    services.xserver = {
      displayManager = {
        sddm.enable = true;
        #lightdm.greeters.mini.enable = true;
      };
    };


    environment.systemPackages = with pkgs; [
      waybar
      hyprpaper

      wl-clipboard
      pulseaudio
      dunst
    ];

    environment.variables = mkIf cfg.nvidia {
      NIXOS_OZONE_WL = "1";
      GBM_BACKEND = "nvidia-drm";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      DISABLE_QT5_COMPAT = "0";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      CLUTTER_BACKEND = "wayland";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };

    # link recursively so other modules can link files in their folders
    home.configFile = {
      "hypr" = {
        source = "${configDir}/hyprland/";
        recursive = true;
      };
      "waybar" = {
        source = "${configDir}/waybar/";
        recursive = true;
      };

    };
  };
}
