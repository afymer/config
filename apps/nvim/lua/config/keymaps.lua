local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>")

-- Tab management
map("n", "<C-t>", "<cmd>tabnew<CR>")
map("n", "<c-tab>", "<cmd>tabnext<cr>")
map("n", "<C-S-Tab>", "<cmd>tabprev<CR>") 

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", ">", ">gv")
map("n", ">", ">gv")
