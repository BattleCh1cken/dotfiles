return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad"
        }
      }



    })
  end
}
