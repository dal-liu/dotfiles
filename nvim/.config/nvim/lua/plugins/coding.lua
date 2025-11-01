return {
  -- completion plugin
  {
    "saghen/blink.cmp",
    cond = not vim.g.vscode,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    version = "1.*",
    opts = {
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      keymap = {
        preset = "none",
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
      },
      snippets = { preset = "luasnip" },
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

  -- add/change/delete delimiter pairs
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
}
