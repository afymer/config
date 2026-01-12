return {
	{
        -- file explorer
		'stevearc/oil.nvim',
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = { "icon", "permissions" },
				view_options = {
					show_hidden = true,
				},
                use_default_keymaps = true,
                keymaps = {
                    ["s"] = false,
                    ["gs"] = { "actions.change_sort", mode = "n" },
                }
			})

            -- HACK: Temporarily override nvim_set_option_value to prevent leap from setting conceallevel to 0
            -- NOTE: Both flash.nvim and mini.jump2d do not set the conceallevel...
            -- Leap issues: 1 and 243
            --
            -- Leap sets conceallevel to 0, intending to prevent incorrect or impossible jumps.
            -- As a consequence the text "shifts", especially in markdown and mini.files.
            -- I favor an incidental "conceallevel" limitation over losing focus because of shifting text.
            local leap_is_active = false
            local nvim_set_option_value = vim.api.nvim_set_option_value
            local no_conceal_on_leap_enter = function(name, value, opts)
                if leap_is_active and name == "conceallevel" then return end
                return nvim_set_option_value(name, value, opts)
            end
            vim.api.nvim_set_option_value = no_conceal_on_leap_enter
            vim.api.nvim_create_autocmd("User", {
                group = vim.api.nvim_create_augroup("ak_leap", {}),
                pattern = "LeapEnter",
                callback = function()
                    -- Triggers before leap enters its LeapEnter callback to set the conceallevel:
                    leap_is_active = true

                    -- Ensure vim.api.nvim_set_option_value operates as before.
                    -- Triggers after leap has set the conceallevel:
                    vim.schedule(function() leap_is_active = false end)
                end,
            })
		end,
	},
    {
        "benomahony/oil-git.nvim",
        dependencies = { "stevearc/oil.nvim" },
    }
}

