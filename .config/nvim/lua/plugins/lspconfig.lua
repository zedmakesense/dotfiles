return {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        -- 'saghen/blink.cmp',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        local lsps = {
            'jsonls',
            'html',
            'cssls',
            'pyright',
            'ts_ls',
            'bashls',
            'lua_ls',
            'texlab',
            'gopls',
            'jdtls',
        }

        for _, lsp in ipairs(lsps) do
            vim.lsp.config(lsp, {
                capabilities = capabilities,
            })
            vim.lsp.enable(lsp)
        end

        -- texlab LSP
        vim.lsp.config('texlab', {
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

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('<leader>d', vim.diagnostic.open_float, 'Show diagnostics float')
                map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
                map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
                map('<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
                map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                vim.diagnostic.config {
                    severity_sort = true,
                    float = { border = 'rounded', source = 'if_many' },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = vim.g.have_nerd_font and {
                        text = {
                            [vim.diagnostic.severity.ERROR] = '󰅚 ',
                            [vim.diagnostic.severity.WARN] = '󰀪 ',
                            [vim.diagnostic.severity.INFO] = '󰋽 ',
                            [vim.diagnostic.severity.HINT] = '󰌶 ',
                        },
                    } or {},
                    virtual_text = true,
                }
            end,
        })
    end,
}
