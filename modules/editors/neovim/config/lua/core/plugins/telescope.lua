return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "%.7z",
          "%.JPEG",
          "%.JPG",
          "%.V",
          "%.RAF",
          "%.burp",
          "%.bz2",
          "%.cache",
          "%.class",
          "%.dll",
          "%.docx",
          "%.dylib",
          "%.epub",
          "%.exe",
          "%.flac",
          "%.ico",
          "%.ipynb",
          "%.jar",
          "%.jpeg",
          "%.jpg",
          "%.lock",
          "%.mkv",
          "%.mov",
          "%.mp4",
          "%.otf",
          "%.pdb",
          "%.pdf",
          "%.png",
          "%.rar",
          "%.sqlite3",
          "%.svg",
          "%.tar",
          "%.tar.gz",
          "%.ttf",
          "%.webp",
          "%.zip",
          ".git/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vale/",
          ".vscode/",
          "__pycache__/*",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "smalljre_*/*",
          "target/",
          "vendor/*",
          "%.d",
          "%.o",
        },
      },
    })
  end,
}
