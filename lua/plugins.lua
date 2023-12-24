require("load_lazy")

-- Indent blankline
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg="#3b4261", nocombine=true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { fg="#3b4261", nocombine=true })
vim.opt.list = true
vim.opt.listchars:append({ space = "⋅", eol = "↴" })

local plugins = {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                close_command = "Bdelete! %d",
                right_mouse_command = "Bdelete! %d",
                offsets = {{
                    filetype = "NvimTree",
                    text = "Explorer",
                    highlight = "Directory",
                    text_align = "center"
                }}
            }
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
--         show_end_of_line = true,
--         space_char_blankline = " ",
        }
    },
    { "famiu/bufdelete.nvim" },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            open_mapping = "<F1>"
        }
    },
    -- git
    { "lewis6991/gitsigns.nvim", config = true },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    -- nvim themes
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            transparent = true
        }
    },
    -- tree-sitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "toml",
                "yaml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
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
        }
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
        }
    },
    { "onsails/lspkind-nvim" }
}

require("lazy").setup(plugins)
require('telescope').load_extension('fzf')
