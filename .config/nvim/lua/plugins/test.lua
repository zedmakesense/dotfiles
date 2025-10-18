return {
    'nvim-neotest/neotest',
    dependencies = {
        { 'nvim-lua/plenary.nvim', lazy = true },
        'nvim-treesitter/nvim-treesitter',
        'nvim-neotest/nvim-nio',
        { 'nvim-neotest/neotest-python', lazy = true },
        { 'fredrikaverpil/neotest-golang', lazy = true },
        { 'rcasia/neotest-java', lazy = true },
        { 'rcasia/neotest-bash', lazy = true },
    },
    keys = {
        {
            '<leader>tn',
            function()
                require('neotest').run.run()
            end,
            desc = 'Neotest: run nearest',
        },
        {
            '<leader>tf',
            function()
                require('neotest').run.run(vim.fn.expand '%')
            end,
            desc = 'Neotest: run file',
        },
        {
            '<leader>td',
            function()
                require('neotest').run.run { strategy = 'dap' }
            end,
            desc = 'Neotest: debug nearest (DAP)',
        },
        {
            '<leader>ts',
            function()
                require('neotest').run.stop()
            end,
            desc = 'Neotest: stop',
        },
        {
            '<leader>to',
            function()
                require('neotest').output_panel.open()
            end,
            desc = 'Neotest: open output panel',
        },
        {
            '<leader>tO',
            function()
                require('neotest').output.open { enter = true }
            end,
            desc = 'Neotest: open last output',
        },
        {
            '<leader>ta',
            function()
                require('neotest').run.attach()
            end,
            desc = 'Neotest: attach to running test',
        },
        {
            '<leader>tS',
            function()
                require('neotest').summary.toggle()
            end,
            desc = 'Neotest: toggle summary',
        },
    },

    config = function()
        local neotest = require 'neotest'

        neotest.setup {
            quickfix = { enabled = false },
            summary = {
                follow = true,
                mappings = {
                    expand = 'o',
                    output = 'O',
                    short = 's',
                },
            },
            adapters = {
                require 'neotest-python' {
                    -- choose runner: "pytest" or "unittest"
                    -- runner = 'pytest',
                    dap = { justMyCode = false },
                },
                require 'neotest-golang'(),
                require 'neotest-java'(),
                require 'neotest-bash'(),
            },
        }
    end,
}
