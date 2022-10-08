{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.cli.nvim;
  autosave-nvim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "autosave-nvim";
    version = "2c7a2943340ee2a36c6a61db812418fca1f57866";
    src = pkgs.fetchFromGitHub {
      owner = "Pocco81";
      repo = "AutoSave.nvim";
      rev = version;
      sha256 = "sha256-keK+IAnHTTA5uFkMivViMMAkYaBvouYqcR+wNPgN3n0=";
    };
    buildInputs = with pkgs; [
      git
      neovim
      lua
    ];
  };
in
{
  options.modules.cli.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      xclip
      #nix
      rnix-lsp
      #lua
      sumneko-lua-language-server
      stylua
      #bash
      shellcheck
      nodePackages.bash-language-server
      shfmt
    ];
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      plugins = with pkgs.master.vimPlugins; [
        plenary-nvim
        #UI 
        catppuccin-nvim
        nvim-web-devicons

        feline-nvim
        bufferline-nvim
        toggleterm-nvim
        #Syntax
        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
        #Utils
        nvim-tree-lua
        telescope-nvim
        indent-blankline-nvim
        nvim-autopairs
        nvim-colorizer-lua
        lightspeed-nvim
        nvim-autopairs
        #autosave-nvim


        #Tmux
        #Comment 
        comment-nvim
        #Git
        gitsigns-nvim
        #Lang specifin Utils
        #Rust
        rust-tools-nvim
        #LSP
        nvim-lspconfig
        null-ls-nvim
        #Completion 
        nvim-cmp
        cmp-nvim-lsp
        cmp-path
        cmp-buffer
        cmp-nvim-lua
        cmp_luasnip
        #Snippets
        luasnip
        friendly-snippets


      ];

      extraConfig = ''
        luafile ~/.config/nvim/config.lua
      '';

    };
    programs.zsh.shellAliases = {
      #n = "neovide --maximized --multigrid";
      n = "nvim";
    };
    home.file.".config/nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
    home.file.".config/nvim/config.lua".source = ./config.lua;


  };
}
