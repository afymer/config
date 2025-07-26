vim.keymap.set("n", "<leader>f", ":Oil<CR>", { desc = "Open [F]ile explorer" })

vim.keymap.set("n", "<leader-S>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

vim.keymap.set(
	"n",
	"<C-Tab>",
	":tabnext<CR>",
	{ noremap = true, silent = true }
)

vim.keymap.set(
	"n",
	"<C-S-Tab>",
	":tabprevious<CR>",
	{ noremap = true, silent = true }
)

vim.keymap.set("n", "<C-j>", "20j")

vim.keymap.set("n", "<C-k>", "20k")
