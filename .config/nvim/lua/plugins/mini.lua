return {
    -- mini.jump
    {
        'echasnovski/mini.jump',
        version = false,
        config = function()
            require('mini.jump').setup()
        end,
    },

    -- mini.pairs
    {
        'echasnovski/mini.pairs',
        event = 'InsertEnter',
        version = false,
        config = function()
            require('mini.pairs').setup()
        end,
    },

    -- mini.icons
    {
        'echasnovski/mini.icons',
        lazy = true,
        version = false,
        config = function()
            require('mini.icons').setup()
        end,
    },

    -- mini.ai
    {
        'echasnovski/mini.ai',
        event = 'InsertEnter',
        version = false,
        config = function()
            require('mini.ai').setup { n_lines = 500 }
        end,
    },

    --mini.pick
    -- {
    --     'echasnovski/mini.pick',
    --     version = '*',
    --     config = function()
    --         require('mini.pick').setup()
    --         vim.keymap.set('n', '<leader>e', function()
    --             require('mini.pick').builtin.files()
    --         end, {})
    --     end,
    -- },
}
