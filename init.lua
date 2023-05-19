require('basic')
require('keymappings')

require('plugins')
require('lsp')

-- Neovide configuration if this is Neovide
if vim.g.neovide then
    require('neovide')
end

vim.cmd[[colorscheme tokyonight]]

