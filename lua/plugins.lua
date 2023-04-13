require("load_lazy")

local plugins = {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    { "lukas-reineke/indent-blankline.nvim" },
    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- nvim themes
    { "folke/tokyonight.nvim" },
    -- LSP Services
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        }
    },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    }
}

require("lazy").setup(plugins)
require("nvim-tree").setup()
require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        offsets = {{
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "Directory",
            text_align = "center"
        }}
    }
})
require("lualine").setup()
require("nvim-treesitter").setup{}

-- Indent blankline
vim.opt.list = true
vim.opt.listchars:append({ space = "⋅", eol = "↴" })
require("indent_blankline").setup {
--     show_end_of_line = true,
--     space_char_blankline = " ",
}

require("tokyonight").setup({
    style = "night",
    transparent = true
})
