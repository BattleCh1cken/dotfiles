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
    ./cli/tmux
    ./cli/scripts

    ./programs/kitty
    ./programs/firefox
    ./programs/steam
    ./programs/rofi

    ./services/dunst
  ];
}
