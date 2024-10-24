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
			local left, right = "", ""

			local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }
			for _, mode in ipairs(modes) do
				custom_dracula[mode].b.fg = colors.fg
				custom_dracula[mode].c.fg = colors.fg
				custom_dracula[mode].c.bg = colors.bg
			end

			local empty = require("lualine.component"):extend()
			function empty:draw(default_highlight)
				self.status = ""
				self.applied_separator = ""
				self:apply_highlights(default_highlight)
				self:apply_section_separators()
				return self.status
			end

			require("lualine").setup({
				options = {
					theme = custom_dracula,
					component_separators = "|",
					section_separators = "",
				},
				sections = {
					lualine_a = { { "mode", separator = { left = " " .. left, right = right } } },
					lualine_b = {
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
						{ "branch", separator = { left = " " .. left, right = right } },
						{ "diff", separator = { right = right } },
						{ "diagnostics", separator = { right = right } },
					},
					lualine_c = {
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
						{
							"filename",
							path = 1,
							color = { bg = colors.visual },
							separator = { left = " " .. left, right = right },
						},
					},
					lualine_x = {
						{
							"filetype",
							color = { bg = colors.visual },
							separator = { left = left, right = right .. " " },
						},
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
					},
					lualine_y = {
						{ "progress", separator = { left = left } },
						{ "location", separator = { right = right .. " " } },
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
					},
					lualine_z = {
						{ "datetime", style = "%I:%M %p", separator = { left = left, right = right .. " " } },
					},
				},
			})
		end,
	},
}
