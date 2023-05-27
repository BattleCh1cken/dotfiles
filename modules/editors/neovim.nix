{ config, options, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.editors.neovim;
  configDir = config.dotfiles.configDir;
  username = config.user.name;
in
{
  options.modules.editors.neovim = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];

    home-manager.users.${username} = {
      programs.neovim = {
        enable = true;
        plugins = with pkgs.unstable.vimPlugins; [
          plenary-nvim
          #UI
          catppuccin-nvim
          nvim-web-devicons

          feline-nvim
          bufferline-nvim
          toggleterm-nvim
          #Syntax
          nvim-treesitter.withAllGrammars
          #Utils
          nvim-tree-lua
          telescope-nvim
          indent-blankline-nvim
          nvim-autopairs
          nvim-colorizer-lua
          lightspeed-nvim
          nvim-autopairs
          impatient-nvim
          auto-save-nvim


          #Tmux
          #Comment
          comment-nvim
          #Git
          gitsigns-nvim
          #Lang specifin Utils
          #Rust
          rust-tools-nvim
          crates-nvim
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

      };
    };


    environment.systemPackages = with pkgs; [
      ripgrep
      fd
      xclip
      lazygit
      #nix
      rnix-lsp
      #lua
      sumneko-lua-language-server
      stylua
      #bash
      shellcheck
      nodePackages.bash-language-server
      shfmt
      # Markdown
      nodePackages.markdownlint-cli
      nodePackages.prettier
    ];

    home.configFile = {
      "nvim" = { source = "${configDir}/nvim"; recursive = true; };
    };

  };
}
