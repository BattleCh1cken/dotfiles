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
            ld = "definition";
            lr = "references";
            rt = "type_definition";
            ri = "implementation";
            K = "hover";
            lrn = "rename";
            lf = "format";
          };
        };

        servers = {
          bashls.enable = true;
          rnix-lsp.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          texlab.enable = true;
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
