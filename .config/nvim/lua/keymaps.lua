-- Keybindings
vim.keymap.set('n', '<Leader>bi', '<cmd>ls<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bd', '<cmd>bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bn', '<cmd>bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bp', '<cmd>bp<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit terminal mode' })

vim.keymap.set('n', 'j', function()
    return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true })

vim.keymap.set('n', 'k', function()
    return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Navigation
vim.keymap.set('n', '<leader>e', '<cmd>18Lex<CR>')

-- Copy/paste with system clipboard
vim.keymap.set({ 'n', 'x', 'v' }, 'gy', '"+y')
vim.keymap.set('n', 'gp', '"+p')

-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set('x', 'gp', '"+P')

-- Movement in insert mode
vim.keymap.set('i', '<M-h>', '<Left>')
vim.keymap.set('i', '<M-j>', '<Down>')
vim.keymap.set('i', '<M-k>', '<Up>')
vim.keymap.set('i', '<M-l>', '<Right>')
