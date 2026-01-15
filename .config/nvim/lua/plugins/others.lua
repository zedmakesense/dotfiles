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
    --     'derektata/lorem.nvim',
    --     even = 'InsertEnter',
    --     config = function()
    --         require('lorem').opts {
    --             sentence_length = 'mixed', -- using a default configuration
    --             comma_chance = 0.3, -- 30% chance to insert a comma
    --             max_commas = 2, -- maximum 2 commas per sentence
    --             debounce_ms = 200, -- default debounce time in milliseconds
    --         }
    --     end,
    -- },
    -- {
    --     'nmac427/guess-indent.nvim',
    --     event = 'BufReadPost',
    --     opts = {},
    -- },
    {
        'MagicDuck/grug-far.nvim',
        cmd = { 'GrugFar', 'GrugFarResume' },
        keys = {
            { '<leader>gf', '<cmd>GrugFar<cr>', desc = 'Grug Find & Replace' },
        },
    },

    {
        'nvim-mini/mini.pairs',
        event = 'InsertEnter',
        version = false,
        opts = {},
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
    -- {
    --     'nvim-mini/mini.jump',
    --     version = false,
    --     opts = {},
    -- },
    -- {
    --     'nvim-mini/mini.jump2d',
    --     version = false,
    --     opts = {},
    -- },
    --
    -- {
    --     'nvim-mini/mini.surround',
    --     event = 'InsertEnter',
    --     version = false,
    --     opts = {},
    -- },

    {
        'tpope/vim-surround',
        event = 'InsertEnter',
    },

    {
        'nvim-mini/mini.icons',
        lazy = true,
        version = false,
        opts = {},
    },

    {
        'nvim-mini/mini.splitjoin',
        event = 'VeryLazy',
        version = false,
        opts = {},
    },

    {
        'nvim-mini/mini.ai',
        event = 'InsertEnter',
        version = false,
        opts = {},
    },

    -- {
    --     'nvim-mini/mini.pick',
    --     version = '*',
    --     cmd = { 'Pick' },
    --     keys = {
    --         {
    --             '<leader>e',
    --             function()
    --                 require('mini.pick').builtin.files()
    --             end,
    --             desc = 'Pick files (mini.pick)',
    --         },
    --     },
    --     opts = {},
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

    {
        'mikavilpas/yazi.nvim',
        version = '*',
        cmd = { 'Yazi' },
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = true },
        },
        keys = {
            {
                '<leader>n',
                mode = { 'n', 'v' },
                '<cmd>Yazi<cr>',
                desc = 'Open yazi at the current file',
            },
            {
                '<leader>-',
                '<cmd>Yazi cwd<cr>',
                desc = "Open the file manager in nvim's working directory",
            },
        },
        init = function()
            vim.g.loaded_netrwPlugin = 1
        end,
    },

    {
        'yazi-rs/plugins',
        lazy = true,
        build = function(plugin)
            local monorepo_dir = plugin.dir
            local want = { 'full-border.yazi', 'smart-paste.yazi' }
            for _, sub in ipairs(want) do
                local sub_plugin = {
                    name = sub,
                    dir = monorepo_dir .. '/' .. sub,
                    repo = 'yazi-rs/plugins:' .. sub,
                }
                require('yazi.plugin').build_plugin(sub_plugin)
            end
        end,
    },

    {
        'dedukun/relative-motions.yazi',
        lazy = true,
        build = function(plugin)
            require('yazi.plugin').build_plugin(plugin)
        end,
    },

    {
        'bennyyip/gruvbox-dark.yazi',
        name = 'gruvbox-dark.yazi',
        lazy = true,
        build = function(spec)
            require('yazi.plugin').build_flavor(spec, {})
        end,
    },
}
