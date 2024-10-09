return {
	-- Configures LuaLS for editing Neovim config files
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Optional `vim.uv` typings
	{ "Bilal2453/luvit-meta", lazy = true },

	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach-set-keymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Go to definition of a variable
					map("gd", vim.lsp.buf.definition, "[G]o to [d]efinition")

					-- Go to references of a variable
					map("gr", vim.lsp.buf.references, "[G]o to [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					map("gi", vim.lsp.buf.implementation, "[G]o to [I]mplementation")

					-- Jump to the type definition of the word under your cursor.
					map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

					-- Show the symbols in the current document.
					map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbol")

					-- Show the symbols in the current workspace.
					map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")

					-- Rename the variable under your cursor.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- Go to declaration
					map("gD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach-disable-ruff-hover", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client == nil then
						return
					end
					if client.name == "ruff" then
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end
				end,
				desc = "LSP: Disable hover capability from Ruff",
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()

			-- Enable the following language servers
			local servers = {
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
				pyright = {
					settings = {
						pyright = {
							-- Using Ruff's import organizer
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								-- Ignore all files for analysis to exclusively use Ruff for linting
								ignore = { "*" },
							},
						},
					},
				},
				ruff = {},
				rust_analyzer = {},
				texlab = {},
				ts_ls = {},
			}

			-- Ensure the servers and tools above are installed
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"prettier",
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
