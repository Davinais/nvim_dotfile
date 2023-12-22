local map = vim.api.nvim_set_keymap
local opt_def = {
    noremap = true,
    silent = true
}

-- Window cmds in normal mode
map("n", "<A-h>", "<C-w>h", opt_def)
map("n", "<A-j>", "<C-w>j", opt_def)
map("n", "<A-k>", "<C-w>k", opt_def)
map("n", "<A-l>", "<C-w>l", opt_def)
map("n", "<C-w>w", ":Bd<CR>", opt_def)

-- Window cmds in terminal mode
map("t", "<Esc>", [[<C-\><C-n>]], opt_def)
map("t", "<A-h>", "<Cmd>wincmd h<CR>", opt_def)
map("t", "<A-j>", "<Cmd>wincmd j<CR>", opt_def)
map("t", "<A-k>", "<Cmd>wincmd k<CR>", opt_def)
map("t", "<A-l>", "<Cmd>wincmd l<CR>", opt_def)

local plugKeys = {}

-- nvim-tree
map("n", "<F4>", ":NvimTreeToggle<CR>", opt_def)
map("t", "<F4>", "<Cmd>NvimTreeToggle<CR>", opt_def)
function plugKeys.lsp_keymaps(buf_map)
    buf_map("n", "gd", ":Lspsaga peek_definition<CR>", opt_def)
    buf_map("n", "gD", ":Lspsaga goto_definition<CR>", opt_def)
    buf_map("n", "gh", ":Lspsaga lsp_finder<CR>", opt_def)
    buf_map("n", "go", ":Lspsaga outline<CR>", opt_def)
    buf_map("n", "gr", ":Lspsaga rename<CR>", opt_def)
    buf_map("n", "gR", ":Lspsaga rename ++project<CR>", opt_def)
    buf_map("n", "gl", ":Lspsaga show_line_diagnostics<CR>", opt_def)
    buf_map("n", "gb", ":Lspsaga show_buf_diagnostics<CR>", opt_def)
    buf_map("n", "gj", ":Lspsaga diagnostic_jump_next<CR>", opt_def)
    buf_map("n", "gk", ":Lspsaga diagnostic_jump_prev<CR>", opt_def)
    buf_map("n", "K", ":Lspsaga hover_doc<CR>", opt_def)
    buf_map("n", "gi", vim.lsp.buf.implementation, opt_def)
end

-- telescope
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", opt_def)
map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>", opt_def)
map("n", "<Leader>fr", "<Cmd>Telescope resume<CR>", opt_def)
map("n", "<Leader>gc", "<Cmd>Telescope git_commits<CR>", opt_def)
map("n", "<Leader>gbc", "<Cmd>Telescope git_bcommits<CR>", opt_def)
map("n", "<Leader>gs", "<Cmd>Telescope git_status<CR>", opt_def)

function plugKeys.cmp_keymaps(cmp)
    return {
        -- Prev and Next item
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- Start cmp
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        -- Abort cmp
        ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Confirm
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({
            select = true ,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' })
    }
end

return plugKeys

