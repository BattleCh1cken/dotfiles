{ inputs, pkgs, config, ... }: {
  imports = [
    ./cli/git
    # ./cli/nvim/default.nix
    # ./programs/kitty/default.nix
    # ./programs/firefox/default.nix
  ];
}
