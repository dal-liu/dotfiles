local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window", remap = true })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window", remap = true })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window", remap = true })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window", remap = true })

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "[b", "<cmd>bprev<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })

map("v", "<", "<gv")
map("v", ">", ">gv")
