-- Basic autocommands
local autocmd = vim.api.nvim_create_augroup('UserConfig', {})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = autocmd,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- removes trailing space on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '',
    command = ':%s/\\s\\+$//e',
})
