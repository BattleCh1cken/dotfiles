{
  imports = [
    ./completion.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./git.nix
    ./comment.nix
    ./toggleterm.nix
    ./bufferline.nix
    ./autopairs.nix
    ./nvimtree.nix
  ];
  programs.nixvim = {
    colorschemes.oxocarbon.enable = true;
  };
}
