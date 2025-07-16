return {
  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("dracula")
    end,
    opts = {
      overrides = function(colors)
        return {
          FloatBorder = { fg = colors.comment },
          BlinkCmpMenuSelection = { bg = colors.selection },
          BlinkCmpScrollBarGutter = { bg = colors.menu },
          BlinkCmpLabel = { fg = colors.fg },
          BlinkCmpLabelDeprecated = { fg = colors.comment },
          BlinkCmpLabelMatch = { fg = colors.cyan },
          BlinkCmpLabelDetail = { fg = colors.fg },
          BlinkCmpKind = { fg = colors.white },
          BlinkCmpKindText = { fg = colors.fg },
          BlinkCmpDoc = { bg = colors.menu },
          BlinkCmpDocBorder = { bg = colors.menu },
          BlinkCmpDocSeparator = { bg = colors.menu },
          SnacksPickerDir = { fg = colors.fg },
        }
      end,
    },
  },
}
