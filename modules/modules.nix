{ inputs, pkgs, config, ... }: {
  imports = [
    ./cli/git
    ./cli/nvim
    ./cli/zsh
    ./programs/kitty/default.nix
    ./programs/firefox/default.nix
  ];
}
