{ inputs, pkgs, config, ... }: {
  home.stateVersion = "22.11";
  imports = [
    ./desktop/bspwm
    ./desktop/eww
    # ./desktop/gnome/default.nix
    # ./desktop/kde/default.nix

    ./cli/git
    ./cli/nvim
    ./cli/zsh
    ./cli/music

    ./programs/kitty
    ./programs/firefox
    ./programs/steam

    ./services/dunst
  ];
}
