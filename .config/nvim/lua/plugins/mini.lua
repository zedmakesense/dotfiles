return {
    -- mini.jump
    -- {
    --     'nvim-mini/mini.jump',
    --     version = false,
    -- opts = {},
    --     end,
    -- },

    -- mini.pairs
    {
        'nvim-mini/mini.pairs',
        event = 'InsertEnter',
        version = false,
        opts = {},
    },

    -- mini.icons
    {
        'nvim-mini/mini.icons',
        lazy = true,
        version = false,
        opts = {},
    },

    -- mini.ai
    {
        'nvim-mini/mini.ai',
        event = 'InsertEnter',
        version = false,
        opts = {},
    },

    --mini.pick
    -- {
    --     'nvim-mini/mini.pick',
    --     version = '*',
    --     config = function()
    --         require('mini.pick').setup()
    --         vim.keymap.set('n', '<leader>e', function()
    --             require('mini.pick').builtin.files()
    --         end, {})
    --     end,
    -- },
}
