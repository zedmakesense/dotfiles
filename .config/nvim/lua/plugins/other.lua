return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
    },

    {
        'mluders/comfy-line-numbers.nvim',
        event = 'VeryLazy',
        opts = {
            number = true,
            relativenumber = true,
            excluded_filetypes = { 'neo-tree', 'NvimTree', 'lazy', 'alpha' },
            threshold = 5,
        },
    },
    {
        'derektata/lorem.nvim',
        even = 'InsertEnter',
        config = function()
            require('lorem').opts {
                sentence_length = 'mixed', -- using a default configuration
                comma_chance = 0.3, -- 30% chance to insert a comma
                max_commas = 2, -- maximum 2 commas per sentence
                debounce_ms = 200, -- default debounce time in milliseconds
            }
        end,
    },
}
