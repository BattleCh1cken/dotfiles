{ inputs, pkgs, config, ... }: {
  imports = [
    ./desktop/bspwm
    ./desktop/eww
    # ./desktop/gnome/default.nix
    # ./desktop/kde/default.nix

    ./cli/git
    ./cli/nvim
    ./cli/zsh

    ./programs/kitty
    ./programs/firefox
    ./programs/steam

    ./services/dunst
  ];
}
