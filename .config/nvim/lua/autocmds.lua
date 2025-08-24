-- Basic autocommands
local augroup = vim.api.nvim_create_augroup('UserConfig', {})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup,
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
    group = augroup,
    pattern = { 'lua', 'python' },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})
