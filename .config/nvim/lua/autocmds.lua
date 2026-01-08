-- Basic autocommands
local autocmd = vim.api.nvim_create_augroup('UserConfig', {})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = autocmd,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
    group = autocmd,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd('FileType', {
    group = autocmd,
    pattern = { 'lua', 'python' },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- Large File Optimization
-- Disables heavy features (Syntax, Treesitter) for files > 20,000 lines.
vim.api.nvim_create_autocmd('BufEnter', {
    group = autocmd,
    pattern = '*',
    callback = function()
        if vim.api.nvim_buf_line_count(0) > 20000 then
            vim.cmd 'syntax off'
            vim.cmd 'TSDisable'
        end
    end,
})

-- removes trailing space on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '',
    command = ':%s/\\s\\+$//e',
})
