local map = vim.keymap.set
-- local opts = { noremap = true, silent = true }

map('n', '<Leader>qd', function()
    vim.cmd 'cclose'
    vim.cmd 'lclose'
end)

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>')

map('n', 'j', function()
    return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true })

map('n', 'k', function()
    return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true })

map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', '<leader>dt', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- Center screen when jumping
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Better indenting in visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Save
map('n', '<C-s>', '<CMD>w<CR>')
map('i', '<C-s>', '<CMD>w<CR>')

-- spell check
map('n', '<leader>sc', ':setlocal spell spelllang=en_us<CR>')

-- Navigation
-- map('n', '<leader>e', '<cmd>18Lex<CR>')

-- Copy/paste with system clipboard
-- map({ 'n', 'x', 'v' }, 'gy', '"+y')
-- map('n', 'gp', '"+p')

-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
-- map('x', 'gp', '"+P')

-- Movement in insert mode
map('i', '<C-h>', '<Left>')
map('i', '<C-l>', '<Right>')
-- map('i', '<C-j>', '<Down>')
-- map('i', '<C-k>', '<Up>')

-- Movement b/w windows
-- map('n', '<M-h>', '<C-w>h')
-- map('n', '<M-l>', '<C-w>l')
-- map('n', '<M-j>', '<C-w>j')
-- map('n', '<M-k>', '<C-w>k')

-- Buffer Management
map('n', '<S-l>', ':bnext<CR>')
map('n', '<S-h>', ':bprevious<CR>')
map('n', '<Leader>bi', '<cmd>ls<CR>')
map('n', '<Leader>bd', '<cmd>bd<CR>')
-- map('n', '<Leader>bn', '<cmd>bn<CR>')
-- map('n', '<Leader>bp', '<cmd>bp<CR>')
