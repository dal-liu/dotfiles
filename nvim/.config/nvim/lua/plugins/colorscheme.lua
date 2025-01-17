return {
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("dracula")
    end,
    config = function()
      require("dracula").setup({
        overrides = function(colors)
          return {
            FloatBorder = { fg = colors.comment },
            BlinkCmpMenuSelection = { bg = colors.selection },
            BlinkCmpScrollBarGutter = { bg = colors.menu },
            BlinkCmpLabel = { fg = colors.fg },
            BlinkCmpLabelDeprecated = { fg = colors.comment },
            BlinkCmpLabelMatch = { fg = colors.cyan },
            BlinkCmpKind = {},
            BlinkCmpDoc = { bg = colors.menu },
            BlinkCmpDocBorder = { bg = colors.menu },
            BlinkCmpDocSeparator = { bg = colors.menu },
            FzfLuaBorder = { fg = colors.comment },
            FzfLuaCursor = { fg = colors.bg, bg = colors.fg },
            FzfLuaPreviewBorder = { fg = colors.comment },
            FzfLuaPreviewTitle = { fg = colors.cyan },
            FzfLuaTitle = { fg = colors.cyan },
          }
        end,
      })
    end,
  },
}
