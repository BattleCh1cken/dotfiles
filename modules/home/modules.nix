{ inputs, pkgs, config, ... }: {
  home.stateVersion = "22.11";
  imports = [
    ./desktop/bspwm
    ./desktop/eww

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
    ./programs/autorandr

    ./services/dunst
  ];
}
