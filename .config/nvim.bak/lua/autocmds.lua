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

-- custom function for install yazi plugins
vim.api.nvim_create_user_command('YaziPluginsInstall', function()
    local lazy = require 'lazy.core.config'
    local plugin = lazy.plugins['plugins']

    if not plugin then
        vim.notify('yazi-rs/plugins is not installed', vim.log.levels.ERROR)
        return
    end

    local monorepo_dir = plugin.dir
    local want = {
        'full-border.yazi',
        'smart-paste.yazi',
        'jump-to-char.yazi',
        'zoom.yazi',
    }

    for _, sub in ipairs(want) do
        require('yazi.plugin').build_plugin {
            name = sub,
            dir = monorepo_dir .. '/' .. sub,
            repo = 'yazi-rs/plugins:' .. sub,
        }
    end
end, {})
