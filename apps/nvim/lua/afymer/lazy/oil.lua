return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			delete_to_trash = true,
			win_options = {
				signcolumn = "auto:2",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name)
					return (name == "..")
				end,
			},
		})
	end,
}
