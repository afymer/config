return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	config = function()
		require("neogit").setup({
			graph_style = "ascii",
			status = { recent_commit_count = 100 },
			integrations = {
				diffview = true,
				disable_relative_line_numbers = false,
			},
		})
	end,
	cmd = "Neogit",
}
