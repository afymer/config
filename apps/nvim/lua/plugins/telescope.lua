return {
	{
        -- fuzzy finder
		"nvim-telescope/telescope.nvim", tag = '*',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					path_display = {
						i = {
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
						},
					},
				},
			})

			telescope.load_extension("fzf")

			local builtin = require('telescope.builtin')

			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
			vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent Files" })
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Keymap" })
		end
	}
}
