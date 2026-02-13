if vim.loop and vim.loop.getuid and vim.loop.getuid() == 0 then
    return {}
end
return {
    'mfussenegger/nvim-dap',
    dependencies = {
        { 'rcarriga/nvim-dap-ui', lazy = true },
        { 'nvim-neotest/nvim-nio', lazy = true },
        { 'theHamsta/nvim-dap-virtual-text', lazy = true },

        { 'leoluz/nvim-dap-go', lazy = true },
        { 'mfussenegger/nvim-dap-python', lazy = true },
        { 'mfussenegger/nvim-jdtls', lazy = true },
    },
    keys = {
        {
            '<F5>',
            function()
                require('dap').continue()
            end,
            desc = 'Debug: Start/Continue',
        },
        {
            '<F1>',
            function()
                require('dap').step_into()
            end,
            desc = 'Debug: Step Into',
        },
        {
            '<F2>',
            function()
                require('dap').step_over()
            end,
            desc = 'Debug: Step Over',
        },
        {
            '<F3>',
            function()
                require('dap').step_out()
            end,
            desc = 'Debug: Step Out',
        },
        {
            '<leader>b',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>B',
            function()
                require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                local dap = require 'dap'
                -- Search for an existing breakpoint on this line in this buffer
                ---@return dap.SourceBreakpoint bp that was either found, or an empty placeholder
                local function find_bp()
                    local buf_bps = require('dap.breakpoints').get(vim.fn.bufnr())[vim.fn.bufnr()]
                    ---@type dap.SourceBreakpoint
                    for _, candidate in ipairs(buf_bps) do
                        if candidate.line and candidate.line == vim.fn.line '.' then
                            return candidate
                        end
                    end
                    return { condition = '', logMessage = '', hitCondition = '', line = vim.fn.line '.' }
                end
                -- Elicit customization via a UI prompt
                ---@param bp dap.SourceBreakpoint a breakpoint
                local function customize_bp(bp)
                    local props = {
                        ['Condition'] = {
                            value = bp.condition,
                            setter = function(v)
                                bp.condition = v
                            end,
                        },
                        ['Hit Condition'] = {
                            value = bp.hitCondition,
                            setter = function(v)
                                bp.hitCondition = v
                            end,
                        },
                        ['Log Message'] = {
                            value = bp.logMessage,
                            setter = function(v)
                                bp.logMessage = v
                            end,
                        },
                    }
                    local menu_options = {}
                    for k, _ in pairs(props) do
                        table.insert(menu_options, k)
                    end
                    vim.ui.select(menu_options, {
                        prompt = 'Edit Breakpoint',
                        format_item = function(item)
                            return ('%s: %s'):format(item, props[item].value)
                        end,
                    }, function(choice)
                        if choice == nil then
                            -- User cancelled the selection
                            return
                        end
                        props[choice].setter(vim.fn.input {
                            prompt = ('[%s] '):format(choice),
                            default = props[choice].value,
                        })
                        -- Set breakpoint for current line, with customizations (see h:dap.set_breakpoint())
                        dap.set_breakpoint(bp.condition, bp.hitCondition, bp.logMessage)
                    end)
                end
                customize_bp(find_bp())
            end,
            desc = 'Debug: Edit Breakpoint',
        },
        {
            '<F7>',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: Toggle UI',
        },
    },

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- Change breakpoint icons
        vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
        vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
        local breakpoint_icons = vim.g.have_nerd_font
                and {
                    Breakpoint = '',
                    BreakpointCondition = '',
                    BreakpointRejected = '',
                    LogPoint = '',
                    Stopped = '',
                }
            or {
                Breakpoint = '●',
                BreakpointCondition = '⊜',
                BreakpointRejected = '⊘',
                LogPoint = '◆',
                Stopped = '⭔',
            }
        for type, icon in pairs(breakpoint_icons) do
            local tp = 'Dap' .. type
            local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
            vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
        end
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        require('dap-go').setup()
        require('dap-python').setup(vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python')

        require('nvim-dap-virtual-text').setup()
    end,
}
