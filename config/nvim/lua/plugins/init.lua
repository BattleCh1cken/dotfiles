local function load_config(name)
	require("plugins.configs." .. name)
end

local plugins_configs = {
	--UI
	"feline",
	"bufferline",
	--Utils
	"telescope",
	"treesitter",
	"comment",
	"nvimtree",
	"indent",
	"autopairs",
	"toggleterm",
	"autosave",
	--Git
	"gitsigns",
	--Completion
	"cmp",
	"luasnip",
	--Rust
	"rust-tools",
	"crates",

	--Other
	"other",
}

for _, plugin_name in ipairs(plugins_configs) do
	load_config(plugin_name)
end
