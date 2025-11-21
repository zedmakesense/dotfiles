return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash',
                    'python',
                    'c',
                    'cpp',
                    'diff',
                    'html',
                    'css',
                    'java',
                    'javascript',
                    'typescript',
                    'json',
                    'lua',
                    'luadoc',
                    'markdown',
                    'markdown_inline',
                    'query',
                    'vim',
                    'vimdoc',
                },
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                modules = {},
                highlight = {
                    enable = true,
                    disable = function(_, bufnr)
                        return vim.api.nvim_buf_line_count(bufnr) > 5000
                    end,
                },
                indent = { enable = true },
                autotag = { enable = true },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_end = {
                            [']A'] = '@parameter.outer',
                            [']F'] = '@function.outer',
                            [']C'] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[A'] = '@parameter.outer',
                            ['[F'] = '@function.outer',
                            ['[C'] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[a'] = '@parameter.outer',
                            ['[f'] = '@function.outer',
                            ['[c'] = '@class.outer',
                        },
                        goto_next_start = {
                            [']a'] = '@parameter.outer',
                            [']f'] = '@function.outer',
                            [']c'] = '@class.outer',
                        },
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = '<CR>',
                            node_incremental = '<CR>',
                            node_decremental = '<S-CR>',
                            scope_incremental = false,
                        },
                    },
                },
            }
            local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
            vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
