return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	keys = { { "f", mode = "n" } },
	config = function()
		require("leap").set_default_mappings()
	end,
}
