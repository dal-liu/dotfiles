return {
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({})
		end,
	},

	-- animated cursor
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
}
