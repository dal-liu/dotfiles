return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		cond = not vim.g.vscode,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "dracula",
				},
				sections = {
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						{
							function()
								local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
								local clients = vim.lsp.get_active_clients()
								if next(clients) == nil then
									return ""
								end
								local lsp_client_names = {}
								for _, client in ipairs(clients) do
									local filetypes = client.config.filetypes
									if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
										table.insert(lsp_client_names, client.name)
									end
								end
								table.sort(lsp_client_names)
								return table.concat(lsp_client_names, ", ")
							end,
							icon = " ",
						},
						{ "filetype" },
					},
				},
			})
		end,
	},
}
