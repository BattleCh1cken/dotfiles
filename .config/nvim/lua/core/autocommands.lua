local api = vim.api



-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- detect typst filetype
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  callback = function()
    vim.api.nvim_command("set filetype=typst")
  end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = { "*.txt", "*.md", "*.tex", ".typ" },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = "en"
    end,
  }
)
