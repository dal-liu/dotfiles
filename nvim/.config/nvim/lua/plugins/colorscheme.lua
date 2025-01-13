return {
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("dracula")
		end,
		config = function()
			require("dracula").setup({
				show_end_of_buffer = true,
				overrides = function(colors)
					return {
						BlinkCmpKind = {},
						BlinkCmpLabel = { fg = colors.fg },
						BlinkCmpLabelDeprecated = { fg = colors.comment },
						BlinkCmpLabelMatch = { fg = colors.cyan },
						FloatBorder = { fg = colors.comment },
						PmenuSel = { bg = colors.selection },
						TelescopeSelection = { bg = colors.selection },
					}
				end,
			})
		end,
	},
}
