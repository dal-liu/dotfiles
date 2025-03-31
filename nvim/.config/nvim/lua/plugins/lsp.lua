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
        basedpyright = {},
        clangd = {
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = { "clangd", "--clang-tidy" },
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
        racket_langserver = {},
        rust_analyzer = {},
        texlab = {},
        ts_ls = {},
        zls = {},
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
          map("gK", function()
            vim.lsp.buf.signature_help({ border = "rounded" })
          end, "Signature help")
          map("K", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, "Hover documentation")
          map("<C-k>", function()
            vim.lsp.buf.signature_help({ border = "rounded" })
          end, "Signature help", "i")
          map("<leader>ca", fzf.lsp_code_actions, "Code action", { "n", "v" })
          map("<leader>cc", vim.lsp.codelens.run, "Run codelens", { "n", "v" })
          map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & display codelens")
          map("<leader>ds", fzf.lsp_document_symbols, "Search document symbols")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle inlay hints")
          map("<leader>ws", fzf.lsp_live_workspace_symbols, "Search workspace symbols")
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup()

      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      local signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " }
      vim.diagnostic.config({
        float = { border = "rounded" },
        signs = false,
        virtual_text = {
          prefix = function(diagnostic)
            return signs[vim.diagnostic.severity[diagnostic.severity]]
          end,
        },
      })
    end,
  },
}
