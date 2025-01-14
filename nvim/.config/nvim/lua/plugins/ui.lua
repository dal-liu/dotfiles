return {
	-- splash screen
	{
		"goolord/alpha-nvim",
		dependencies = {
			"echasnovski/mini.icons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("alpha").setup(require("alpha.themes.theta").config)
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		cond = not vim.g.vscode,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({})
		end,
	},

	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
}
