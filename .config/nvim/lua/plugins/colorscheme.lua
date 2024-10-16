return {
	-- Dracula
	{
		"dracula/vim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("dracula")
		end,
	},

	-- One Dark Pro
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("onedark")
		end,
		config = function()
			local colors = require("onedarkpro.helpers").get_colors()
			require("onedarkpro").setup({
				highlights = {
					CursorLineNr = { fg = colors.white, extend = true },
				},
				styles = {
					comments = "italic",
				},
				options = {
					cursorline = true,
				},
			})
		end,
	},
}
