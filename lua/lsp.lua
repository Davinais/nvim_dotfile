local os_name = vim.loop.os_uname().sysname

-- https://github.com/ayamir/nvimdots/blob/main/lua/modules/configs/completion/servers/clangd.lua
local function get_binary_path(binary)
    local path = nil
    if os_name == "Darwin" or os_name == "Linux" then
        path = vim.fn.trim(vim.fn.system("which " .. binary))
    elseif os_name == "Windows_NT" then
        path = vim.fn.trim(vim.fn.system("where " .. binary))
    end
    if vim.v.shell_error ~= 0 then
        path = nil
    end
    return path
end

-- https://github.com/ayamir/nvimdots/blob/main/lua/modules/configs/completion/servers/clangd.lua
local function get_binary_path_list(binaries)
    local path_list = {}
    for _, binary in ipairs(binaries) do
        local path = get_binary_path(binary)
        if path then
            table.insert(path_list, path)
        end
    end
    return table.concat(path_list, ",")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
    local function buf_map(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    require("keymappings").lsp_keymaps(buf_map)
end

-- clangd
require("lspconfig").clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "-j=8",
        "--background-index",
        "--pch-storage=memory",
        -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
        "--query-driver=" .. get_binary_path_list({ "g++", "gcc" }),
        "--clang-tidy",
        "--enable-config",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion-decorators",
        "--header-insertion=iwyu",
	},
}
-- pylsp
require("lspconfig").pylsp.setup {
    on_attach = on_attach,
}
