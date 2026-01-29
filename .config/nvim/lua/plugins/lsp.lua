if vim.loop and vim.loop.getuid and vim.loop.getuid() == 0 then
    return {}
end
return {
    {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        dependencies = {
            -- 'saghen/blink.cmp',
            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            local lsps = {
                'jsonls',
                'html',
                'cssls',
                'ruff',
                'ts_ls',
                'bashls',
                'lua_ls',
                'gopls',
            }
            for _, lsp in ipairs(lsps) do
                vim.lsp.config(lsp, {
                    capabilities = capabilities,
                    on_attach = function(client, _)
                        client.server_capabilities.diagnosticProvider = false
                    end,
                })
                vim.lsp.enable(lsp)
            end

            -- texlab LSP
            vim.lsp.config('texlab', {
                on_attach = function(client, _)
                    client.server_capabilities.diagnosticProvider = true
                end,
                settings = {
                    texlab = {
                        build = {
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = 'zathura',
                            args = { '--synctex-forward', '%l:1:%f', '%p' },
                        },
                        chktex = {
                            onOpenAndSave = true,
                        },
                        latexFormatter = 'tex-fmt',
                        bibtexFormatter = 'tex-fmt',
                    },
                },
                capabilities = capabilities,
            })
            vim.lsp.enable 'texlab'

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- Diagnostics
                    -- map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
                    -- map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
                    map('<leader>d', vim.diagnostic.open_float, 'Show diagnostics float')
                    map('<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
                    -- LSP actions
                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                    -- LSP navigation (quickfix / jump)
                    map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')
                    map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
                    map('grd', vim.lsp.buf.definition, '[G]oto [D]efinition')
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
                    -- Signature help
                    map('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
                    -- Document / workspace symbols (quickfix alternative)
                    map('gO', vim.lsp.buf.document_symbol, 'Open Document Symbols')
                    map('gW', vim.lsp.buf.workspace_symbol, 'Open Workspace Symbols')

                    -- vim.diagnostic.enable(false)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    client.server_capabilities.documentFormattingProvider = false
                end,
            })
        end,
    },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPost', 'BufWritePost' },
        config = function()
            local ok, lint = pcall(require, 'lint')
            if not ok then
                vim.notify('nvim-lint not found', vim.log.levels.ERROR)
                return
            end

            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
                -- json = { 'jsonlint' },
                sh = { 'shellcheck' },
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
                html = { 'htmlhint' },
                css = { 'stylelint' },
                lua = { 'luacheck' },
                python = { 'ruff' },
                java = { 'checkstyle' },
                go = { 'golangcilint' },
            }

            -- Create autocommand which carries out the actual linting
            -- on the specified events.
            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    if not vim.bo.modifiable then
                        return
                    end
                    -- if any LSP client is active for this buffer, skip external linting
                    -- if next(vim.lsp.get_clients { bufnr = 0 }) ~= nil then
                    --     return
                    -- end
                    require('lint').try_lint()
                end,
            })
        end,
    },
    {
        'stevearc/conform.nvim',
        cmd = { 'ConformFormat', 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = true,
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'ruff_format' },
                sh = { 'shfmt' },
                javascript = { 'prettierd' },
                javascriptreact = { 'prettierd' },
                css = { 'prettierd' },
                html = { 'prettierd' },
                json = { 'prettierd' },
                tex = { 'tex-fmt' },
                plaintex = { 'tex-fmt' },
                markdown = { 'markdownlint' },
                java = { 'google-java-format' },
                go = { 'goimports', 'gofumpt' },
            },
        },
    },
    {
        {
            'saghen/blink.cmp',
            version = '1.*',
            event = { 'InsertEnter', 'CmdlineEnter' },
            dependencies = {
                {
                    'L3MON4D3/LuaSnip',
                    version = '2.*',
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                            return
                        end
                        return 'make install_jsregexp'
                    end)(),
                    dependencies = {
                        {
                            'rafamadriz/friendly-snippets',
                            config = function()
                                require('luasnip.loaders.from_vscode').lazy_load()
                            end,
                        },
                    },
                    opts = {},
                },
                'onsails/lspkind.nvim',
                'folke/lazydev.nvim',
            },
            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            opts = {
                keymap = {
                    preset = 'default',
                },
                appearance = {
                    nerd_font_variant = 'mono',
                },
                completion = {
                    -- menu = {
                    --     enabled = false,
                    -- },
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true,
                        },
                    },
                    documentation = {
                        auto_show = false,
                        auto_show_delay_ms = 500,
                    },
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
                    providers = {
                        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                    },
                },
                snippets = { preset = 'luasnip' },
                signature = { enabled = true },
                fuzzy = { implementation = 'prefer_rust_with_warning' },
            },
        },
    },
}
