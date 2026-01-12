return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "K", function() 
                vim.lsp.buf.hover { 
                    border = "rounded", 
                    max_height = 25, 
                    max_width = 120,
                } 
            end, 
            desc = "Hover documentation" 
        },
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
}
