require("load_lazy")

-- Indent blankline
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg="#3b4261", nocombine=true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { fg="#3b4261", nocombine=true })
vim.opt.list = true
vim.opt.listchars:append({ space = "⋅", eol = "↴" })

local plugins = {
    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
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
        event = "VeryLazy",
        opts = {
            sections = {
                lualine_b = { { "branch", fmt = function(str) return str:sub(1, 16) end }, "diff", "diagnostics" }
            }
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        main = "ibl",
        opts = {
--         show_end_of_line = true,
--         space_char_blankline = " ",
        }
    },
    {
        "famiu/bufdelete.nvim",
        cmd = "Bdelete"
    },
    {
        "akinsho/toggleterm.nvim",
        keys = { "<F1>" },
        version = "*",
        opts = {
            open_mapping = "<F1>"
        }
    },
    -- git
    { "lewis6991/gitsigns.nvim", config = true },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
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
        lazy = true,
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
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
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
        },
        opts = {
            lightbuln = {
                sign = false,
            },
        }
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
        },
        opts = function()
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
            return {}
        end
    },
    { "onsails/lspkind-nvim" }
}

require("lazy").setup(plugins)
require('telescope').load_extension('fzf')
