return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        dependencies = {
            'windwp/nvim-ts-autotag',
        },
        init = function()
            require('nvim-treesitter').setup {
                -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
                install_dir = vim.fn.stdpath 'data' .. '/site',
            }
            require('nvim-treesitter').install {
                -- core / editor
                'bash',
                'lua',
                'vim',
                'vimdoc',

                -- data / config
                'json',
                'yaml',
                'toml',
                'ini',
                'xml',
                'sql',

                -- markup / docs
                'markdown',
                'markdown_inline',
                'html',
                'css',

                -- programming languages
                'c',
                'cpp',
                'go',
                'gomod',
                'gosum',
                'python',
                'javascript',
                'typescript',
                'tsx',
                'java',
                'rust',
                'nix',

                -- scripting / tooling
                'regex',
                'make',
                'cmake',
                'dockerfile',
                'gitignore',
                'gitcommit',
                'diff',

                -- shells / terminals
                'awk',
                'printf',
                'comment',

                -- misc but useful
                'query',
            }
            vim.api.nvim_create_autocmd('FileType', {
                desc = 'User: enable treesitter highlighting',
                callback = function(args)
                    -- highlights
                    local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

                    -- large file guard
                    -- if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                    --     return
                    -- end

                    -- indent
                    local noIndent = {}
                    if hasStarted and not vim.list_contains(noIndent, args.match) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.wo[0][0].foldmethod = 'expr'
                    end
                end,
            })
        end,
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            vim.g.no_plugin_maps = true
        end,
        config = function()
            local move = require 'nvim-treesitter-textobjects.move'

            -- next start
            vim.keymap.set({ 'n', 'x', 'o' }, ']a', function()
                move.goto_next_start('@parameter.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
                move.goto_next_start('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
                move.goto_next_start('@class.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']i', function()
                move.goto_next_start('@conditional.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']l', function()
                move.goto_next_start('@loop.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
                move.goto_next_start('@local.scope', 'locals')
            end)

            -- next end
            vim.keymap.set({ 'n', 'x', 'o' }, ']A', function()
                move.goto_next_end('@parameter.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
                move.goto_next_end('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']C', function()
                move.goto_next_end('@class.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']I', function()
                move.goto_next_end('@conditional.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']L', function()
                move.goto_next_end('@loop.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']S', function()
                move.goto_next_end('@local.scope', 'locals')
            end)

            -- previous start
            vim.keymap.set({ 'n', 'x', 'o' }, '[a', function()
                move.goto_previous_start('@parameter.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
                move.goto_previous_start('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
                move.goto_previous_start('@class.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[i', function()
                move.goto_previous_start('@conditional.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[l', function()
                move.goto_previous_start('@loop.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[s', function()
                move.goto_previous_start('@local.scope', 'locals')
            end)

            -- previous end
            vim.keymap.set({ 'n', 'x', 'o' }, '[A', function()
                move.goto_previous_end('@parameter.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
                move.goto_previous_end('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[C', function()
                move.goto_previous_end('@class.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[I', function()
                move.goto_previous_end('@conditional.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[L', function()
                move.goto_previous_end('@loop.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[S', function()
                move.goto_previous_end('@local.scope', 'locals')
            end)

            local select = require 'nvim-treesitter-textobjects.select'

            -- assignments
            vim.keymap.set({ 'x', 'o' }, 'a=', function()
                select.select_textobject('@assignment.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'i=', function()
                select.select_textobject('@assignment.inner', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'l=', function()
                select.select_textobject('@assignment.lhs', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'r=', function()
                select.select_textobject('@assignment.rhs', 'textobjects')
            end)

            -- parameters / arguments
            vim.keymap.set({ 'x', 'o' }, 'aa', function()
                select.select_textobject('@parameter.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'ia', function()
                select.select_textobject('@parameter.inner', 'textobjects')
            end)

            -- conditionals
            vim.keymap.set({ 'x', 'o' }, 'ai', function()
                select.select_textobject('@conditional.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'ii', function()
                select.select_textobject('@conditional.inner', 'textobjects')
            end)

            -- loops
            vim.keymap.set({ 'x', 'o' }, 'al', function()
                select.select_textobject('@loop.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'il', function()
                select.select_textobject('@loop.inner', 'textobjects')
            end)

            -- function calls
            vim.keymap.set({ 'x', 'o' }, 'aC', function()
                select.select_textobject('@call.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'iC', function()
                select.select_textobject('@call.inner', 'textobjects')
            end)

            -- function / method definitions
            vim.keymap.set({ 'x', 'o' }, 'af', function()
                select.select_textobject('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'if', function()
                select.select_textobject('@function.inner', 'textobjects')
            end)

            -- classes
            vim.keymap.set({ 'x', 'o' }, 'ac', function()
                select.select_textobject('@class.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'ic', function()
                select.select_textobject('@class.inner', 'textobjects')
            end)

            local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'
            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            -- vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
            -- vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
            vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

            vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    },
}
