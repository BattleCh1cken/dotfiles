{ config, options, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.editors.emacs;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    user.packages = with pkgs; [
      # required dependencies
      git
      emacs # Emacs 27.2
      ripgrep
      # optional dependencies
      coreutils # basic GNU utilities
      fd
      clang
    ];


  };
}
