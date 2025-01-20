return {
  -- treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      ignore_install = { "latex" },
      endwise = {
        enable = true,
      },
      modules = {},
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- automatically add "end" in ruby, lua, etc.
  "RRethy/nvim-treesitter-endwise",

  -- auto close and rename html tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
