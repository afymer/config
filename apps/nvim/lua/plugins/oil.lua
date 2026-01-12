return {
	{
        -- file explorer
		'stevearc/oil.nvim',
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = { "icon" },
				view_options = {
					show_hidden = true,
				},
			})
		end,
	}
}

