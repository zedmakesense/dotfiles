return {
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                'nvim-dap-ui',
            },
        },
    },
    {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle Undotree' },
        },
    },

    -- {
    --     'mluders/comfy-line-numbers.nvim',
    --     event = 'VeryLazy',
    --     opts = {
    --         number = true,
    --         relativenumber = true,
    --         excluded_filetypes = { 'neo-tree', 'NvimTree', 'lazy', 'alpha' },
    --         threshold = 5,
    --     },
    -- },
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
    {
        'nmac427/guess-indent.nvim',
        event = 'BufReadPost',
        opts = {},
    },
    {
        'MagicDuck/grug-far.nvim',
        cmd = { 'GrugFar', 'GrugFarResume' },
        keys = {
            { '<leader>gf', '<cmd>GrugFar<cr>', desc = 'Grug Find & Replace' },
        },
    },

    -- mini.jump
    -- {
    --     'nvim-mini/mini.jump',
    --     version = false,
    -- opts = {},
    --     end,
    -- },

    -- mini.pairs
    -- {
    --     'nvim-mini/mini.pairs',
    --     event = 'InsertEnter',
    --     version = false,
    --     opts = {},
    -- },

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
    {
        {
            'lervag/vimtex',
            ft = { 'tex', 'plaintex' },
            init = function()
                vim.g.vimtex_view_method = 'zathura'
                vim.g.vimtex_compiler_method = 'latexmk'
                vim.g.vimtex_compiler_latexmk = {
                    build_dir = 'build',
                    options = {
                        '-pdf',
                        '-interaction=nonstopmode',
                        '-synctex=1',
                    },
                }
                -- Do not open quickfix automatically
                vim.g.vimtex_quickfix_mode = 0
            end,
        },
    },
}
