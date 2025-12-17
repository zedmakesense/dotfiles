return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        dependencies = {
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                desc = 'User: enable treesitter highlighting',
                callback = function(args)
                    local bufnr = args.buf
                    -- highlights
                    local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

                    -- large file guard
                    if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                        return
                    end

                    -- indent
                    local noIndent = {}
                    if hasStarted and not vim.list_contains(noIndent, args.match) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
            vim.g.no_plugin_maps = true
        end,
        config = function()
            local move = require 'nvim-treesitter.textobjects.move'

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

            local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
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
