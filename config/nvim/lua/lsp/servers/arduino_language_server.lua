local M = {}

local DEFAULT_FQBN = "arduino:avr:uno"

-- When the arduino server starts in these directories, use the provided FQBN.
-- Note that the server needs to start exactly in these directories.
-- This example would require some extra modification to support applying the FQBN on subdirectories!
local my_arduino_fqbn = {
	["/home/battlechicken/Documents/Projects/arduino/test"] = "arduino:avr:uno",
}

M.setup = function(on_attach, capabilities)
	require("lspconfig").arduino_language_server.setup({
		on_new_config = function(config, root_dir)
			local fqbn = my_arduino_fqbn[root_dir]
			if not fqbn then
				vim.notify(("Could not find which FQBN to use in %q. Defaulting to %q."):format(root_dir, DEFAULT_FQBN))
				fqbn = DEFAULT_FQBN
			end
			config.cmd = {
				"arduino-language-server",
				"-cli-config",
				root_dir .. "/arduino-cli.yaml",
				"-fqbn",
				fqbn,
			}
		end,
	})
end

return M
