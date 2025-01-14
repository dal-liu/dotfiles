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
		cond = not vim.g.vscode,
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
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				pyright = {},
				racket_langserver = {},
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
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					local fzf = require("fzf-lua")
					map("gd", fzf.lsp_definitions, "Go to definition")
					map("gr", fzf.lsp_references, "Go to references")
					map("gD", fzf.lsp_declarations, "Go to declaration")
					map("gI", fzf.lsp_implementations, "Go to implementation")
					map("<leader>ds", fzf.lsp_document_symbols, "Document symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ws", fzf.lsp_live_workspace_symbols, "Workspace symbols")
					map("<leader>D", fzf.lsp_typedefs, "Type definition")
					map("K", vim.lsp.buf.hover, "Hover documentation")
				end,
			})

			local signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " }
			local diagnostic_signs = {}
			for type, icon in pairs(signs) do
				diagnostic_signs[vim.diagnostic.severity[type]] = icon
			end
			vim.diagnostic.config({
				float = { border = "single" },
				signs = { text = diagnostic_signs },
				virtual_text = { prefix = "●" },
			})

			require("mason").setup()
			require("mason-lspconfig").setup()

			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				config.handlers = {
					["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
					["textDocument/signatureHelp"] = vim.lsp.with(
						vim.lsp.handlers.signature_help,
						{ border = "single" }
					),
				}
				lspconfig[server].setup(config)
			end
		end,
	},
}
