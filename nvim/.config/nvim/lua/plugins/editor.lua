return {
  -- fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        keymap = {
          builtin = {
            true,
            ["<C-d>"] = "preview-page-down",
            ["<C-u>"] = "preview-page-up",
          },
          fzf = {
            true,
            ["ctrl-d"] = "preview-page-down",
            ["ctrl-u"] = "preview-page-up",
          },
        },
        winopts = {
          preview = {
            scrollbar = false,
            winopts = {
              number = false,
            },
          },
        },
      })

      local function map(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = desc })
      end

      local fzf = require("fzf-lua")
      map("<leader>gc", fzf.git_commits, "Search git commits")
      map("<leader>gf", fzf.git_files, "Search git files")
      map("<leader>gs", fzf.git_status, "Search git status")
      map("<leader>sb", fzf.buffers, "Search buffers")
      map("<leader>sd", fzf.diagnostics_document, "Search diagnostics")
      map("<leader>sf", fzf.files, "Search files")
      map("<leader>sg", fzf.live_grep, "Search by grep")
      map("<leader>sh", fzf.helptags, "Search help tags")
      map("<leader>sk", fzf.keymaps, "Search keymaps")
      map("<leader>so", fzf.oldfiles, "Search old files")
      map("<leader>sr", fzf.resume, "Search resume")
      map("<leader>sw", fzf.grep_cword, "Search current word")
    end,
  },

  -- git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Jump to next git change" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Jump to previous git change" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = "Diff this ~" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
      end,
    },
  },

  -- file explorer
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },

  -- highlight todos
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
    },
  },

  -- show pending keybinds
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("which-key").setup({
        preset = "modern",
      })
      require("which-key").add({
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Document" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hunk" },
        { "<leader>r", group = "Rename" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
        { "<leader>w", group = "Workspace" },
        { "<localleader>l", group = "LaTeX" },
      })
    end,
  },
}
