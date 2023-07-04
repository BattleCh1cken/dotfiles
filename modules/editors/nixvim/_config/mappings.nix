{config, ...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal."<Space>" = "<NOP>";

      # Esc to clear search results
      normal."<esc>" = ":noh<CR>";

      # fix Y behaviour
      normal."Y" = "y$";

      # back and fourth between the two most recent files
      normal."<C-c>" = ":b#<CR>";

      # close by Ctrl+x
      normal."<C-x>" = ":close<CR>";

      # navigate to left/right window
      normal."<leader>h" = "<C-w>h";
      normal."<leader>l" = "<C-w>l";

      # resize with arrows
      normal."<C-Up>" = ":resize -2<CR>";
      normal."<C-Down>" = ":resize +2<CR>";
      normal."<C-Left>" = ":vertical resize +2<CR>";
      normal."<C-Right>" = ":vertical resize -2<CR>";

      # better indenting
      visual.">" = ">gv";
      visual."<" = "<gv";
      visual."<TAB>" = ">gv";
      visual."<S-TAB>" = "<gv";

      # move selected line / block of text in visual mode
      visual."K" = ":m '<-2<CR>gv=gv";
      visual."J" = ":m '>+1<CR>gv=gv";

      # Plugins

      # NvimTree
      normal."<leader>n" = ":NvimTreeToggle<CR>";

      # Bufferline
      normal."<TAB>" = "<cmd>BufferLineCycleNext<CR>";
      normal."<S-TAB>" = "<cmd>BufferLineCyclePrev<CR>";
    };
  };
}
