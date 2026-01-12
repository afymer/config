return {
	{
        -- make . work with plugins
        "tpope/vim-repeat" },
	{
        -- good ol' leap
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			local leap = require("leap")

			vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
			vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
		end,
	}
}
