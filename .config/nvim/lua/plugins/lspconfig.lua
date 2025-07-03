return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        require('cmp_nvim_lsp').default_capabilities(capabilities)

        local lsps = {
            'jsonls',
            'html',
            'cssls',
            'pyright',
            'ts_ls',
            'bashls',
            'lua_ls',
            'marksman',
            'texlab',
            'ltex_plus',
        }

        for _, lsp in ipairs(lsps) do
            vim.lsp.config(lsp, {
                capabilities = capabilities,
            })
            vim.lsp.enable(lsp)
        end

        -- texlab LSP
        vim.lsp.start {
            name = 'texlab',
            cmd = { 'texlab' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'main.tex', '.git' }, { upward = true })[1]),
            settings = {
                texlab = {
                    build = {
                        executable = 'latexmk',
                        args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                        onSave = true,
                    },
                    forwardSearch = {
                        executable = 'zathura',
                        args = { '--synctex-forward', '%l:1:%f', '%p' },
                    },
                },
            },
        }

        -- ltex-ls-plus LSP (grammar + spell check)
        vim.lsp.start {
            name = 'ltex_plus',
            cmd = { 'ltex_plus' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'main.tex', '.git' }, { upward = true })[1]),
            settings = {
                ltex = {
                    language = 'en',
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = 'en',
                    },
                },
            },
        }

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                map('grr', function()
                    require('fzf-lua').lsp_references()
                end, '[G]oto [R]eferences')
                map('gri', function()
                    require('fzf-lua').lsp_implementations()
                end, '[G]oto [I]mplementation')
                map('grd', function()
                    require('fzf-lua').lsp_definitions()
                end, '[G]oto [D]efinition')
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('gO', function()
                    require('fzf-lua').lsp_document_symbols()
                end, 'Open Document Symbols')
                map('gW', function()
                    require('fzf-lua').lsp_workspace_symbols()
                end, 'Open Workspace Symbols')
                map('grt', function()
                    require('fzf-lua').lsp_typedefs()
                end, '[G]oto [T]ype Definition')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
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
                    virtual_text = {
                        source = 'if_many',
                        spacing = 2,
                        format = function(diagnostic)
                            local diagnostic_message = {
                                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                                [vim.diagnostic.severity.WARN] = diagnostic.message,
                                [vim.diagnostic.severity.INFO] = diagnostic.message,
                                [vim.diagnostic.severity.HINT] = diagnostic.message,
                            }
                            return diagnostic_message[diagnostic.severity]
                        end,
                    },
                }
            end,
        })
    end,
}
