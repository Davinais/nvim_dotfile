require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
--        "clangd",
--        "pylsp",
    }
})

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

-- clangd
require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        local function buf_map(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        require("keymappings").lsp_keymaps(buf_map)
    end,
    cmd = {
        "clangd",
        "-j=8",
        "--background-index",
        "--pch-storage=memory",
        -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
        "--query-driver=" .. get_binary_path_list({ "g++", "clang++", "clang", "gcc" }),
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
    on_attach = function(client, bufnr)
        local function buf_map(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        require("keymappings").lsp_keymaps(buf_map)
    end,
}
require("lspsaga").setup{}

local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" }
    }, {
        { name = "buffer" },
        { name = "path" }
    }),
    mapping = require("keymappings").cmp_keymaps(cmp),
    formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function (entry, vim_item)
            -- Display source name
            vim_item.menu = "["..string.upper(entry.source.name).."]"
            return vim_item
        end
    })
    }
}
-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

