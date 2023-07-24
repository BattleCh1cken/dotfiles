{
  imports = [
    ./completion.nix
    ./lsp.nix
    ./autosave.nix
    ./autopairs.nix
    ./bufferline.nix
    ./comment.nix
    ./git.nix
    ./indent-blankline.nix
    ./nvimtree.nix
    ./telescope.nix
    ./treesitter.nix
    ./toggleterm.nix
  ];
  programs.nixvim = {
    colorschemes.oxocarbon.enable = true;
    plugins = {
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
      typst-vim.enable = true;
    };
  };
}
