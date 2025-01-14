return {
	-- highlight todos
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- show pending keybinds
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.icons",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("which-key").setup({
				preset = "modern",
			})
			require("which-key").add({
				{ "<leader>d", group = "Document" },
				{ "<leader>h", group = "Git hunk", mode = { "n", "v" } },
				{ "<leader>l", group = "LaTeX" },
				{ "<leader>r", group = "Rename" },
				{ "<leader>s", group = "Search" },
				{ "<leader>t", group = "Toggle" },
				{ "<leader>w", group = "Workspace" },
			})
		end,
	},

	-- fuzzy finder
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				fzf_colors = true,
				keymap = {
					builtin = {
						["<C-d>"] = "preview-page-down",
						["<C-u>"] = "preview-page-up",
					},
					fzf = {
						["ctrl-b"] = "half-page-up",
						["ctrl-d"] = "preview-page-down",
						["ctrl-f"] = "half-page-down",
						["ctrl-u"] = "preview-page-up",
					},
				},
				winopts = {
					preview = {
						winopts = {
							number = false,
						},
					},
				},
			})

			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = desc })
			end

			local fzf = require("fzf-lua")
			map("<leader>sf", fzf.files, "Search files")
			map("<leader>sg", fzf.live_grep, "Search by grep")
			map("<leader>sr", fzf.resume, "Search resume")
			map("<leader>sw", fzf.grep_cword, "Search current word")
			map("<leader>s.", fzf.oldfiles, "Search old files")
			map("<leader><leader>", fzf.buffers, "Find existing buffers")
		end,
	},

	-- git integration
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next git change" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous git change" })

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage hunk" })
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk" })
				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame line" })
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git toggle blame" })
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff against last commit" })
				map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Git toggle deleted" })
			end,
		},
	},

	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = {
					width = 30,
				},
			})
			vim.keymap.set("n", "<leader>tn", ":Neotree toggle<CR>", { desc = "Toggle neo-tree" })
		end,
	},
}
