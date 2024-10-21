return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local custom_dracula = require("lualine.themes.dracula")
			local colors = require("dracula").colors()
			local modes = {
				normal = colors.purple,
				insert = colors.green,
				visual = colors.yellow,
				replace = colors.red,
				command = colors.orange,
				inactive = colors.selection,
			}
			for mode, color in pairs(modes) do
				custom_dracula[mode].a.fg = colors.black
				custom_dracula[mode].a.bg = color
				custom_dracula[mode].b.fg = colors.fg
				custom_dracula[mode].b.bg = colors.bg
				custom_dracula[mode].c.fg = colors.fg
				custom_dracula[mode].c.bg = colors.bg
			end

			require("lualine").setup({
				options = {
					theme = custom_dracula,
					component_separators = "|",
					section_separators = "",
				},
				sections = {
					lualine_a = { { "mode", separator = { left = "", right = "" } } },
					lualine_b = { "filename", "branch", "diff", "diagnostics" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "filetype", "progress" },
					lualine_z = { { "location", separator = { left = "", right = "" } } },
				},
			})
		end,
	},
}
