return {
	-- Gruvbox Material
	{
		"sainnhe/gruvbox-material",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			vim.g.gruvbox_material_foreground = "mix"
			-- vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	-- One Dark Pro
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			vim.cmd.colorscheme("onedark")
		end,
		config = function()
			local colors = require("onedarkpro.helpers").get_colors()
			require("onedarkpro").setup({
				highlights = {
					["@comment"] = { fg = colors.comment, italic = true },
					CursorLineNr = { fg = colors.white, extend = true },
				},
				options = {
					cursorline = true,
				},
			})
		end,
	},
}
