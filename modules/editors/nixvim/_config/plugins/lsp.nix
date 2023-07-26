{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            "<leader>ld" = "definition";
            "<leader>lr" = "references";
            "<leader>rt" = "type_definition";
            "<leader>ri" = "implementation";
            e = "hover";
            "<leader>lrn" = "rename";
            "<leader>lf" = "format";
          };
        };

        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          texlab.enable = true;
          typst-lsp.enable = true;
          typst-lsp.extraOptions.settings = {
            exportPdf = "onType";
          };
          rust-analyzer.enable = true;
        };
      };

      null-ls = {
        enable = true;
        sources = {
          formatting.alejandra.enable = true;
        };
      };
    };
  };
}
