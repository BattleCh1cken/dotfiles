local M = {}

M.colors = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yelow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  saphire = "#74c7ec",
  blue = "#87b0f9",
  lavender = "#b4befe",
  text = "#c6d0f5",
  subtext1 = "#b3bcdf",
  subtext0 = "#a1a8c9",
  overlay1 = "#8e95b3",
  overlay0 = "#696d86",
  surface2 = "#565970",
  surface1 = "#43465a",
  surface0 = "#363a4f",	
  base = "#24273a",
  mantle = "#1e2030",
  crust = "#181926",
}


M.init = function()
local isExistCatppuccin, catppuccin = pcall(require, "catppuccin")
if isExistCatppuccin then
  catppuccin.setup({
      custom_highlights = {
    Feline = {
      fg = M.colors.text,
      bg = M.colors.mantle,
   },

   FelineIcon = {
      fg = M.colors.mantle,
      bg = M.colors.blue,
   },

   FelineIconSeparator = {
      fg = M.colors.blue,
      bg = M.colors.surface1,
   },

   FelineFileName = {
      fg = M.colors.text,
      bg = M.colors.surface1,
   },

   FelineFileName_Separator = {
      fg = M.colors.surface1,
      bg = M.colors.surface0,
   },

   FelineDirName = {
      fg = M.colors.text,
      bg = M.colors.surface0,
   },

   FelineDirName_Separator = {
      fg = M.colors.surface0,
      bg = M.colors.mantle,
   },

   Feline_diffIcons = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   -- LSP

   Feline_lspError = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   Feline_lspWarning = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   Feline_LspHints = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   Feline_LspInfo = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   Feline_LspIcon = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   Feline_LspProgress = {
      fg = M.colors.text,
      bg = M.colors.base,
   },

   -- MODES

   Feline_NormalMode = {
      fg = M.colors.mantle,
      bg = M.colors.green,
   },

   Feline_InsertMode = {
      fg = M.colors.mantle,
      bg = M.colors.mauve,
   },

   Feline_TerminalMode = {
      fg = M.colors.mantle,
      bg = M.colors.red,
   },

   Feline_VisualMode = {
      fg = M.colors.mantle,
      bg = M.colors.blue,
   },

   Feline_ReplaceMode = {
      fg = M.colors.red,
      bg = M.colors.base,
   },

   Feline_ConfirmMode = {
      fg = M.colors.red,
      bg = M.colors.red,
   },

   Feline_CommandMode = {
      fg = M.colors.red,
      bg = M.colors.base,
   },

   Feline_SelectMode = {
      fg = M.colors.red,
      bg = M.colors.base,
   },

   Feline_EmptySpace = {
      fg = M.colors.red,
      bg = M.colors.base,
   },

   Feline_CurrentLine = {
      fg = M.colors.text,
      bg = M.colors.surface1,
   },

   Feline_PositionIcon = {
      fg = M.colors.surface1,
      bg = M.colors.green,
   },

   Feline_PositionSeparator = {
      fg = M.colors.green,
      bg = M.colors.surface1,
   },

}
    })
  -- Lua
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
  vim.cmd[[colorscheme catppuccin]]
end
end
return M
