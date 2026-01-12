return {
	{
        -- cool but lacks clarity with c code
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({})
		end,
	},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
