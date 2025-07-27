local default_dark_theme = "tokyonight-night"

return { -- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("tokyonight").setup({
			styles = {
				comments = { italic = false }, -- Disable italics in comments
			},
		})

		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme(default_dark_theme)
		vim.keymap.set("n", "<leader>tl", function()
			local theme = vim.g.colors_name
			if theme == default_dark_theme then
				vim.cmd.colorscheme("tokyonight-day")
			else
				vim.cmd.colorscheme(default_dark_theme)
			end
		end, { desc = "Switch between [T]heme [L]ight and dark" })
	end,
}
