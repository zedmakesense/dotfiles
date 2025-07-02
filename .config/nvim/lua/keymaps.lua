-- Keybindings
vim.keymap.set('n', '<Leader>bi', '<cmd>ls<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bd', '<cmd>bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bn', '<cmd>bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bp', '<cmd>bp<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit terminal mode' })
