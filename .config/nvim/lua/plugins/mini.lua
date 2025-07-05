return {
    {
        'echasnovski/mini.statusline',
        version = false,
        event = 'VeryLazy',
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = vim.g.have_nerd_font }
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                local col = vim.fn.col '.'
                local total_col = vim.fn.col '$' - 1
                return string.format('%d:%d', col, total_col)
            end
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
