local M = {}

M.setup = function(on_attach, capabilities)
    require("lspconfig").rust_analyzer.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end

return M
