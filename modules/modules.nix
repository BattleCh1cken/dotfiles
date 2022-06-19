{ inputs, pkgs, config, ... }: {
  imports = [
    ./desktop/gnome/default.nix

    ./cli/git
    ./cli/nvim
    ./cli/zsh

    ./programs/kitty/default.nix
    ./programs/firefox/default.nix
    ./programs/steam/default.nix
  ];
}
