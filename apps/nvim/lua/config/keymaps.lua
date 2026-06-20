local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("c", "w!!", "w !sudo tee % > /dev/null")
