local files = {
    "lazy_bootstrap",
    "colours",
    "lsp",
    "settings",
    "lazy"
}

for i, file in ipairs(files) do
    local module_name = "config." .. file
    local status, err = pcall(require, module_name)
    if not status then
        vim.notify("Error loading " .. module_name .. ": " .. err, vim.log.levels.ERROR)
    end
end


-- require("config.lazy")
-- require("config.theme")
-- require("config.languages")
-- require("config.keymaps")
-- require("config.commands")

