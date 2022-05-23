local M = {}

M.colors = {
  bg = "#1E1E2E",
  fg = "#D9E0EE",
  red = "#F28FAD",
  orange = "#E8A2AF",
  yellow = "#FAE3B0",
  blue = "#96CDFB",
  green = "#ABE9B3",
  cyan = "#89DCEB",
  magenta = "#DDB6F2",
  black0 = "#161320",
  black1 = "#1A1826",
  black2 = "#1E1E2E",
  black3 = "#302D41",
  black4 = "#575268",
  grey0 = "#6E6C7E",
  grey1 = "#988BA2",
  grey2 = "#C3BAC6",
  white = "#D9E0EE",
  white1 = "#C9CBFF",
  white2 = "#F5E0DC"
}

M.init = function()
  local isExistCatppuccin, catppuccin = pcall(require, "catppuccin")
  if isExistCatppuccin then
  print("Catppuccin activated")
  catppuccin.setup({
  theme = nil, -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
  borders = true, -- Split window borders
  fade_nc = false, -- Fade non-current windows, making them more distinguishable
  -- Style that is applied to various groups: see `highlight-args` for options
  styles = {
    comments = "NONE",
    strings = "NONE",
    keywords = "NONE",
    functions = "NONE",
    variables = "NONE",
    diagnostics = "underline",
  },
  disable = {
    background = false, -- Disable setting the background color
    cursorline = false, -- Disable the cursorline
    eob_lines = true, -- Hide the end-of-buffer lines
  },
  -- Inverse highlight for different groups
  inverse = {
    match_paren = false,
  },
  custom_highlights = {
    TelescopePromptPrefix = { bg = M.colors.black0 },
    TelescopePromptNormal = { bg = M.colors.black0},
    TelescopeResultsNormal = { bg = M.colors.black1},
    TelescopePreviewNormal = { bg = M.colors.black0 },
    TelescopePromptBorder = { bg = M.colors.black0, fg = M.colors.black0 },
    TelescopeResultsBorder = { bg = M.colors.black1, fg = M.colors.black0 },
    TelescopePreviewBorder = { bg = M.colors.black0, fg = M.colors.black0 },
    TelescopePromptTitle = { fg = M.colors.black0 },
    TelescopeResultsTitle = { fg = M.colors.black0 },
    TelescopePreviewTitle = { fg = M.colors.black0 },

  }, -- Overwrite default highlight groups
  custom_colors = {}, -- Overwrite default colors})
  })
end
end

return M
