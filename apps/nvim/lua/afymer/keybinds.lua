local function key(mode, lhs, rhs)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.set("n", "<leader>f", ":Oil<CR>", { desc = "Open [F]ile explorer" })

vim.keymap.set("", "<C-Tab>", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set(
	"",
	"<C-S-Tab>",
	":tabprevious<CR>",
	{ noremap = true, silent = true }
)

key("n", "<Tab>", ">>")
key("n", "<S-Tab>", "<<")

key("v", "<Tab>", ">gv")
key("v", "<S-Tab>", "<gv")

-- Move
key("v", "J", ":m '>+1<CR>gv=gv")
key("v", "K", ":m '<-2<CR>gv=gv")

key("n", "<C-j>", "20j")
key("n", "<C-k>", "20k")

key("n", "<C-S-E>", "20<C-E>")
key("n", "<C-S-Y>", "20<C-Y>")

key("n", "<leader>l", function()
	vim.lsp.buf.hover()
end)

key("n", "<C-n>", ":tabnew<CR>:Oil<CR>")
