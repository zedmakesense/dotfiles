return {
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'echasnovski/mini.icons' },
        opts = {},
        -- stylua: ignore
        keys = {
            { '<leader>sh', function() require('fzf-lua').help_tags() end, desc = '[S]earch [H]elp' },
            { '<leader>sk', function() require('fzf-lua').keymaps() end, desc = '[S]earch [K]eymaps' },
            { '<leader>sg', function() require('fzf-lua').live_grep() end, desc = '[S]earch by [G]rep' },
            { '<leader>s.', function() require('fzf-lua').oldfiles() end, desc = '[S]earch Recent Files ("." for repeat)' },
            { '<leader>sb', function() require('fzf-lua').buffers() end, desc = '[ ] Find existing buffers' },
            -- { '<leader>sv', function() require('fzf-lua').live_grep({ cwd = '~/.wiki' }) end, desc = '[S]earch [V]imwiki' },
        },
    },

    {
        'otavioschwanck/fzf-lua-explorer.nvim',
        dependencies = { 'ibhagwan/fzf-lua', 'echasnovski/mini.icons' },
        -- stylua: ignore
        keys = {
            { '<leader>sf', function() require('fzf-lua-explorer').explorer() end, desc = 'Explorer' },
        },
        config = function()
            require('fzf-lua-explorer').setup()
        end,
    },
}
