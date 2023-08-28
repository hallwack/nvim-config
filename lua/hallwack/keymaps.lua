local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

map("n", "<C-b>", ":Neotree toggle<CR>", default_opts)
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", default_opts)
map("n", "<leader>gr", "<cmd>lua require('telescope.builtin').live_grep()<cr>", default_opts)
map("n", "<leader>bf", "<cmd>lua require('telescope.builtin').buffers()<cr>", default_opts)
map("i", "jj", "<Esc>", default_opts)
map("v", "aa", "<Esc>", default_opts)
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<A-h>", ":vertical resize -2<CR>", default_opts)
map("n", "<A-l>", ":vertical resize +2<CR>", default_opts)
map("n", "<A-j>", ":resize +2<CR>", default_opts)
map("n", "<A-k>", ":resize -2<CR>", default_opts)
map("v", "J", ":m '>+1<CR>gv=gv", default_opts)
map("v", "K", ":m '<-2<CR>gv=gv", default_opts)
