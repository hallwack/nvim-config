local map = vim.keymap.set

local function default_options(description)
  return { noremap = true, silent = true, desc = description }
end

map("n", "<C-b>", ":NvimTreeToggle toggle<CR>", default_options("For toogle NvimTreeToggle"))
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>",
  default_options("For searching files using telescope"))
map("n", "<leader>gr", "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  default_options("For searching string using grep"))
map("n", "<leader>bf", "<cmd>lua require('telescope.builtin').buffers()<cr>", default_options("For show buffer list(s)"))
map("i", "jj", "<Esc>", default_options("For escape"))
map("v", "aa", "<Esc>", default_options("For escape (but in visual mode)"))
map("n", "<C-h>", "<C-w>h", default_options("For move cursor to left window"))
map("n", "<C-l>", "<C-w>l", default_options("For move cursor to right window"))
map("n", "<C-j>", "<C-w>j", default_options("For move cursor to bottom window"))
map("n", "<C-k>", "<C-w>k", default_options("For move cursor to top window"))
map("n", "<A-h>", ":vertical resize -2<CR>", default_options("For increase window size vertically"))
map("n", "<A-l>", ":vertical resize +2<CR>", default_options("For decrease window size vertically"))
map("n", "<A-j>", ":resize +2<CR>", default_options("For increase window size horizontally"))
map("n", "<A-k>", ":resize -2<CR>", default_options("For decrease window size horizontally"))
map("v", "J", ":m '>+1<CR>gv=gv", default_options("For moving line to top"))
map("v", "K", ":m '<-2<CR>gv=gv", default_options("For moving line to bottom"))
map("x", "<leader>p", '"_dP', default_options("For paste word"))
map("n", "<leader>tn", ":tabnew<CR>:Telescope find_files<CR>", default_options("For new tab and show searching files"))
map("n", "git", ":LazyGit<CR>", default_options("For showing Lazygit"))
