return {
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
          auto_show_delay_ms = 500,
        },
      },
      keymap = {
        preset = "default",
        ["<Tab>"] = { "accept", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up" },
        ["<C-d>"] = { "scroll_documentation_down" },
        ["<C-f>"] = {},
        ["<C-l>"] = { "snippet_forward" },
        ["<C-h>"] = { "snippet_backward" },
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

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

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
  --
  -- automatically close pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      disable_filetype = { "tex" },
    },
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
}
