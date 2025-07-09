return {
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
}
