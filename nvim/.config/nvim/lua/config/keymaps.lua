local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Go to right window", remap = true })

map("n", "[b", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bn<cr>", { desc = "Next buffer" })

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear hlsearch" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open location list" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open quickfix list" })

map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
