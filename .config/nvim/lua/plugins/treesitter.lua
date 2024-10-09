return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = {
				enable = true,
				disable = { "ruby" },
			},
			ignore_install = { "latex" },
			endwise = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- Automatically add closing characters for some languages
	"RRethy/nvim-treesitter-endwise",
}
