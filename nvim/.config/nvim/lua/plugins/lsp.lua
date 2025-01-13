return {
	-- configure LuaLS for editing neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			servers = {
				clangd = {
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
				},
				cssls = {},
				eslint = {},
				gopls = {},
				html = {},
				lua_ls = {},
				pyright = {},
				rust_analyzer = {},
				texlab = {},
				ts_ls = {},
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach-set-keymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "Go to definition")
					map("gr", require("telescope.builtin").lsp_references, "Go to references")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("K", vim.lsp.buf.hover, "Hover documentation")
				end,
			})

			require("mason").setup()

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = {},
				handlers = {
					function(server_name)
						local config = opts.servers[server_name] or {}
						config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
						config.handlers = {
							["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
							["textDocument/signatureHelp"] = vim.lsp.with(
								vim.lsp.handlers.signature_help,
								{ border = "single" }
							),
						}
						require("lspconfig")[server_name].setup(config)
					end,
				},
			})

			require("lspconfig").racket_langserver.setup({})

			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				float = {
					border = "single",
				},
				virtual_text = {
					prefix = "●",
				},
			})
		end,
	},
}
