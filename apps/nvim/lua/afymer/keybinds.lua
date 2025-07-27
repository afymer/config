vim.keymap.set(
	"",
	"<C-S-Tab>",
	":tabprevious<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>f", ":Oil<CR>", { desc = "Open [F]ile explorer" })

vim.keymap.set("", "<C-Tab>", ":tabnext<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Move text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-j>", "20j")
vim.keymap.set("n", "<C-k>", "20k")

vim.keymap.set("n", "<C-S-E>", "20<C-E>")
vim.keymap.set("n", "<C-S-Y>", "20<C-Y>")

vim.keymap.set("n", "<leader>l", function()
	vim.lsp.buf.hover()
end)
