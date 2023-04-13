local map = vim.api.nvim_set_keymap
local opt_def = {
    noremap = true,
    silent = true
}

-- Switch window
map("n", "<A-h>", "<C-w>h", opt_def)
map("n", "<A-j>", "<C-w>j", opt_def)
map("n", "<A-k>", "<C-w>k", opt_def)
map("n", "<A-l>", "<C-w>l", opt_def)

local plugKeys = {}

-- nvim-tree
map("n", "<F4>", ":NvimTreeToggle<CR>", opt_def)
function plugKeys.lsp_keymaps(buf_map)
    buf_map("n", "gd", ":Lspsaga peek_definition<CR>", opt_def)
    buf_map("n", "gD", ":Lspsaga goto_definition<CR>", opt_def)
    buf_map("n", "gh", ":Lspsaga lsp_finder<CR>", opt_def)
    buf_map("n", "go", ":Lspsaga outline<CR>", opt_def)
    buf_map("n", "gr", ":Lspsaga rename<CR>", opt_def)
    buf_map("n", "gR", ":Lspsaga rename ++project<CR>", opt_def)
    buf_map("n", "gl", ":Lspsaga show_line_diagnostics<CR>", opt_def)
    buf_map("n", "gc", ":Lspsaga show_cursor_diagnostics<CR>", opt_def)
    -- keymap("n", "K", vim.lsp.buf.hover, opt_def)
    buf_map("n", "K", ":Lspsaga hover_doc<CR>", opt_def)
    buf_map("n", "gi", vim.lsp.buf.implementation, opt_def)
end

return plugKeys

