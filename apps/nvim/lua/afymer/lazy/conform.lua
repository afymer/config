local formatters = {

	-----------------
	--- Dedicated ---
	-----------------

	lua = { "stylua" },
	rust = { "rustfmt" },
	sql = { "sql_formatter" },
	python = { "ruff" },
	toml = { "taplo" },

	-------------
	--- Shell ---
	-------------

	sh = { "shfmt" },
	bash = { "shfmt" },

	----------------
	--- Prettier ---
	----------------

	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	html = { "prettier" },
	css = { "prettier" },
	json = { "prettier" },
	jsonc = { "prettier" },
	markdown = { "prettier" },

	--------------------
	--- Clang Format ---
	--------------------

	-- for .h: vim.g.c_syntax_for_h = 1 (see settings.lua)
	c = { "clang-format" },
	cpp = { "clang-format" },

	--------------
	--- Custom ---
	--------------
}

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 1000,
			},
			formatters_by_ft = formatters,
		})
	end,
}
