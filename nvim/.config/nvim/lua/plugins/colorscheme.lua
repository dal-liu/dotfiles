return {
	-- Dracula
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("dracula")
		end,
		config = function()
			require("dracula").setup({
				overrides = function(colors)
					return {
						CmpItemAbbr = { fg = colors.fg, bg = colors.menu },
						NormalFloat = { fg = colors.fg, bg = colors.menu },
						StatusLine = { fg = colors.fg, bg = colors.bg },
						TelescopeSelection = { fg = colors.fg, bg = colors.selection },
					}
				end,
				show_end_of_buffer = true,
			})
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
