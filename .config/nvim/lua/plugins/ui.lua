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
			local left = { left = " ", right = "" }
			local right = { left = "", right = " " }

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
					lualine_a = {
						{ "mode", separator = left },
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
					},
					lualine_b = {
						{ "branch", separator = left },
						{ "diff", separator = left },
						{ "diagnostics", separator = left },
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
					},
					lualine_c = {
						{ "filename", path = 1, color = { bg = colors.visual }, separator = left },
					},
					lualine_x = {
						{ "filetype", color = { bg = colors.visual }, separator = right },
						{
							function()
								local msg = ""
								local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
								local clients = vim.lsp.get_active_clients()
								if next(clients) == nil then
									return msg
								end
								local first = true
								for _, client in ipairs(clients) do
									local filetypes = client.config.filetypes
									if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
										if first then
											msg = client.name
											first = false
										else
											msg = msg .. ", " .. client.name
										end
									end
								end
								return msg
							end,
							icon = " ",
							color = { bg = colors.visual },
							separator = right,
						},
					},
					lualine_y = {
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
						{ "progress", separator = right },
					},
					lualine_z = {
						{ empty, color = { fg = colors.bg, bg = colors.bg } },
						{ "location", separator = right },
					},
				},
			})
		end,
	},
}
