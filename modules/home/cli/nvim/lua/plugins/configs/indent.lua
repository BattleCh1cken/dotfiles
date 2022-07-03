local ok, indent = pcall(require, "indent_blankline")

if not ok then
    return
end

indent.setup {
    char = "▏",
    context_char = "▏",
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = false,
    show_trailing_blankline_indent = false,
    filetype_exclude = {
        "TelescopePrompt",
        "NvimTree",
        "help",
        "txt",
        "markdown",
    },
    buftype_exclude = { "terminal", "nofile" },
}
