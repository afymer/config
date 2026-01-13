return {
	{
        -- file explorer
		'stevearc/oil.nvim',
		-- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
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
                win_options = {
                    signcolumn = "yes:2",
                },
                keymaps = {
                    ["<CR>"] = "actions.select",
                    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-V>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["-"] = { "actions.parent", mode = "n" },
                    -- ["g?"] = { "actions.show_help", mode = "n" },
                    -- ["<C-p>"] = "actions.preview",
                    -- ["<C-c>"] = { "actions.close", mode = "n" },
                    -- ["<C-l>"] = "actions.refresh",
                    -- ["_"] = { "actions.open_cwd", mode = "n" },
                    -- ["`"] = { "actions.cd", mode = "n" },
                    -- ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                    -- ["gs"] = { "actions.change_sort", mode = "n" },
                    -- ["gx"] = "actions.open_external",
                    -- ["g."] = { "actions.toggle_hidden", mode = "n" },
                    -- ["g\\"] = { "actions.toggle_trash", mode = "n" },
                },
                use_default_keymaps = false,
			})

            -- HACK: Temporarily override nvim_set_option_value to prevent leap from setting conceallevel to 0
            -- NOTE: Both flash.nvim and mini.jump2d do not set the conceallevel...
            -- Leap issues: 1 and 243
            --
            -- Leap sets conceallevel to 0, intending to prevent incorrect or impossible jumps.
            -- As a consequence the text "shifts", especially in markdown and mini.files.
            -- I favor an incidental "conceallevel" limitation over losing focus because of shifting text.
            -- local leap_is_active = false
            -- local nvim_set_option_value = vim.api.nvim_set_option_value
            -- local no_conceal_on_leap_enter = function(name, value, opts)
            --     if leap_is_active and name == "conceallevel" then return end
            --     return nvim_set_option_value(name, value, opts)
            -- end
            -- vim.api.nvim_set_option_value = no_conceal_on_leap_enter
            -- vim.api.nvim_create_autocmd("User", {
            --     group = vim.api.nvim_create_augroup("ak_leap", {}),
            --     pattern = "LeapEnter",
            --     callback = function()
            --         -- Triggers before leap enters its LeapEnter callback to set the conceallevel:
            --         leap_is_active = true
            --
            --         -- Ensure vim.api.nvim_set_option_value operates as before.
            --         -- Triggers after leap has set the conceallevel:
            --         vim.schedule(function() leap_is_active = false end)
            --     end,
            -- })
		end,
	},
    {
        "refractalize/oil-git-status.nvim",

        dependencies = {
            "stevearc/oil.nvim",
        },

        config = true,
    },
}

