return {
    {
        -- syntax highlighting and parsing
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "rust", "c", "cpp" },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_hightlighting = false,
                },
                indent = { enable = true },
            })
        end
    },
    {
        -- completion menu
        'saghen/blink.cmp',
        version = '*',
        opts = {
            signature = { enabled = true },
            keymap = { preset = 'default' },
            appearance = { use_nvim_cmp_as_default = true },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
    },
    {
        -- connects to language servers
        "neovim/nvim-lspconfig"
    },
    {
        -- code formatting (can fallback to lsp apparently)
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "prettier" },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
    }
}

