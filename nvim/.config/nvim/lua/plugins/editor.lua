return {
  -- fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      winopts = {
        preview = {
          scrollbar = false,
        },
      },
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
      },
    },
    config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)

      local function map(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { desc = desc })
      end

      map("<leader><leader>", fzf.buffers, "Find existing buffers")
      map("<leader>gf", fzf.git_files, "Search Git files")
      map("<leader>gs", fzf.git_status, "Search Git status")
      map("<leader>sd", fzf.diagnostics_document, "Search diagnostics")
      map("<leader>sf", fzf.files, "Search files")
      map("<leader>sg", fzf.live_grep, "Search by grep")
      map("<leader>sh", fzf.helptags, "Search helptags")
      map("<leader>sk", fzf.keymaps, "Search keymaps")
      map("<leader>sn", function()
        FzfLua.files({ cwd = vim.fn.stdpath("config") })
      end, "Search Neovim files")
      map("<leader>sr", fzf.resume, "Search resume")
      map("<leader>sw", fzf.grep_cword, "Search current word")
      map("<leader>sw", fzf.grep_visual, "Search visual", "x")
      map("<leader>s.", fzf.oldfiles, "Search recent files")
      map("<leader>/", fzf.grep_curbuf, "Fuzzily search in current buffer")
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
      preview_config = {
        border = "rounded",
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
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Blame line" })

        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = "Diff this ~" })

        map("n", "<leader>hQ", function()
          gitsigns.setqflist("all")
        end, { desc = "Set quickfix list all" })
        map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set quickfix list" })

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
        map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
      end,
    },
  },

  -- file explorer
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "echasnovski/mini.icons", opts = {} },
    keys = {
      { "<leader>e", ":Oil<CR>", desc = "Open file explorer" },
    },
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
    },
    opts = {
      preset = "modern",
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("which-key").add({
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>h", group = "Hunk" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
        { "<localleader>l", group = "LaTeX" },
      })
    end,
  },
}
