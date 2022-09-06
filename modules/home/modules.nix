{ inputs, pkgs, config, ... }: {
  home.stateVersion = "22.11";
  imports = [
    ./desktop/bspwm
    ./desktop/hyprland
    ./desktop/river
    ./desktop/eww

    ./cli/git
    ./cli/nvim
    ./cli/zsh
    ./cli/tmux
    ./cli/fzf
    ./cli/scripts

    ./programs/kitty
    ./programs/firefox
    ./programs/steam
    ./programs/rofi
    ./programs/autorandr

    ./services/dunst
  ];
}
