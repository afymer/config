-- Setup lazy.nvim
require("lazy").setup({
        spec = {
                { import = "plugins" },
        },
        checker = {
                enabled = false,
                notify = false
        },
        change_detection = {
                enabled = true,
                notify = false,
        }
})

