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
				group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
				callback = function(event)
					local function map(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
					end

					local fzf = require("fzf-lua")
					map("gd", fzf.lsp_definitions, "Go to definition")
					map("gr", fzf.lsp_references, "Go to references")
					map("gy", fzf.lsp_typedefs, "Go to type definition")
					map("gD", fzf.lsp_declarations, "Go to declaration")
					map("gI", fzf.lsp_implementations, "Go to implementation")
					map("gK", vim.lsp.buf.signature_help, "Signature help")
					map("K", vim.lsp.buf.hover, "Hover documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")
					map("<leader>ca", fzf.lsp_code_actions, "Code action", { "n", "v" })
					map("<leader>cr", vim.lsp.buf.rename, "Rename")
					map("<leader>ss", fzf.lsp_document_symbols, "Search document symbols")
					map("<leader>sS", fzf.lsp_live_workspace_symbols, "Search workspace symbols")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						vim.lsp.inlay_hint.enable()
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")
					end
				end,
			})

			local signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " }
			vim.diagnostic.config({
				float = { border = "single" },
				signs = false,
				virtual_text = {
					prefix = function(diagnostic)
						return signs[vim.diagnostic.severity[diagnostic.severity]]
					end,
				},
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
