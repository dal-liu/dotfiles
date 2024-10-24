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
			local lightgray = "#5f6a8e"
			local left, right = "", ""

			local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }
			for _, mode in ipairs(modes) do
				custom_dracula[mode].b.fg = colors.fg
				custom_dracula[mode].c.fg = colors.fg
				custom_dracula[mode].c.bg = colors.bg
			end

			local left_sep = require("lualine.component"):extend()
			function left_sep:draw(default_highlight)
				self.status = " " .. left
				self.applied_separator = ""
				self:apply_highlights(default_highlight)
				self:apply_section_separators()
				return self.status
			end

			local right_sep = require("lualine.component"):extend()
			function right_sep:draw(default_highlight)
				self.status = right .. " "
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
						{ left_sep, color = { fg = lightgray, bg = colors.bg } },
						{ "branch" },
						{ "diff" },
						{ "diagnostics" },
						{ right_sep, color = { fg = lightgray, bg = colors.bg } },
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							color = { bg = colors.visual },
							separator = { left = left, right = right },
						},
					},
					lualine_x = {
						{
							"filetype",
							color = { bg = colors.visual },
							separator = { left = left, right = right },
						},
					},
					lualine_y = {
						{ left_sep, color = { fg = lightgray, bg = colors.bg } },
						{ "progress" },
						{ "location" },
						{ right_sep, color = { fg = lightgray, bg = colors.bg } },
					},
					lualine_z = {
						{ "datetime", style = "%I:%M %p", separator = { left = left, right = right .. " " } },
					},
				},
			})
		end,
	},
}
