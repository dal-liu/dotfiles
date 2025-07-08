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
        matlab_ls = {},
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

          local snacks = require("snacks")
          map("gra", vim.lsp.buf.code_action, "Goto code action", { "n", "x" })
          map("grd", snacks.picker.lsp_definitions, "Goto definition")
          map("gri", snacks.picker.lsp_implementations, "Goto implementation")
          map("grn", vim.lsp.buf.rename, "Rename")
          map("grr", snacks.picker.lsp_references, "Goto references")
          map("grt", snacks.picker.lsp_type_definitions, "Goto type definition")
          map("grD", snacks.picker.lsp_declarations, "Goto declaration")
          map("gK", function()
            vim.lsp.buf.signature_help({ border = "rounded" })
          end, "Signature help")
          map("gO", snacks.picker.lsp_symbols, "Open document symbols")
          map("gW", snacks.picker.lsp_workspace_symbols, "Open workspace symbols")
          map("K", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, "Hover documentation")
          map("<C-s>", function()
            vim.lsp.buf.signature_help({ border = "rounded" })
          end, "Signature help", "i")
          map("<leader>cc", vim.lsp.codelens.run, "Run codelens", { "n", "v" })
          map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & display codelens")
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle inlay hints")
        end,
      })

      require("mason").setup()
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
