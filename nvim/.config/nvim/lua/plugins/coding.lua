return {
	-- detect tabstop and shiftwidth
	"tpope/vim-sleuth",

	-- github copilot
	{
		"github/copilot.vim",
		cond = not vim.g.vscode,
		init = function()
			vim.g.copilot_no_tab_map = true
		end,
		config = function()
			vim.keymap.set("i", "<C-f>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
		end,
	},

	-- add/change/delete delimiter pairs
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- completion plugin
	{
		"saghen/blink.cmp",
		cond = not vim.g.vscode,
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			completion = {
				documentation = {
					auto_show = true,
					window = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
					},
				},
			},
			keymap = {
				preset = "none",
				["<C-d>"] = { "scroll_documentation_down" },
				["<C-e>"] = { "cancel" },
				["<C-h>"] = { "snippet_backward" },
				["<C-l>"] = { "snippet_forward" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-u>"] = { "scroll_documentation_up" },
				["<C-Space>"] = { "show" },
				["<Tab>"] = { "accept", "fallback" },
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},

	-- automatically close pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			disable_filetype = { "tex" },
		},
	},
}
