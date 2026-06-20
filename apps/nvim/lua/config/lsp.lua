local lsps = {
    rs = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        settings = {
            ['rust-analyzer'] = {
                check = { command = 'clippy' },
                diagnostics = {
                    styleLints = { enable = true },
                    disabled = { 'inactive-code' },
                },
                imports = {
                    granularity = { group = 'module' },
                    preferNoStd = true,
                },
                inlayHints = {
                    bindingModeHints = { enable = true },
                    maxLength = nil,
                },
            },
        },
    },
}


for name, config in pairs(lsps) do
    vim.lsp.enable(name)
    if config['root_markers'] == nil then config['root_markers'] = {} end
    for _, marker in ipairs({ '.git', '.' }) do
        table.insert(config['root_markers'], marker)
    end
    vim.lsp.config(name, config)
end
