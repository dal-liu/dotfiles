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
				colors = {
					bg = "#282a36",
					fg = "#f6f6f4",
					red = "#ee6666",
					orange = "#ffb86c",
					yellow = "#e7ee98",
					green = "#62e884",
					purple = "#bf9eee",
					cyan = "#97e1f1",
					pink = "#f286c4",
					white = "#f6f6f4",
					bright_red = "#f07c7c",
					bright_green = "#78f09a",
					bright_yellow = "#f6f6ae",
					bright_blue = "#d6b4f7",
					bright_magenta = "#f49dda",
					bright_cyan = "#adf6f6",
					bright_white = "#ffffff",
				},
				overrides = function(colors)
					return {
						CmpItemAbbr = { fg = colors.fg, bg = colors.menu },
						CmpItemKind = { fg = colors.fg, bg = colors.menu },
						NormalFloat = { fg = colors.fg, bg = colors.menu },
					}
				end,
				italic_comment = false,
				transparent_bg = false,
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
