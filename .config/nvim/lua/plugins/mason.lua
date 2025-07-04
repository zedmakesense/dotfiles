return {
    {
        'williamboman/mason.nvim',
        event = 'VeryLazy',
        build = ':MasonUpdate',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = 'VeryLazy',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'VeryLazy',
                callback = function()
                    require('mason-lspconfig').setup {
                        automatic_installation = false,
                        ensure_installed = {
                            'pyright',
                            'bashls',
                            'html',
                            'jsonls',
                            'cssls',
                            'ts_ls',
                            'lua_ls',
                            'marksman',
                            'texlab',
                        },
                    }
                end,
            })
        end,
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'ruff',
                    'black',
                    'stylua',
                    'prettierd',
                    'shfmt',
                    'markdownlint',
                    'luacheck',
                    'shellcheck',
                    'eslint_d',
                    'stylelint',
                    'tex-fmt',
                },
                automatic_installation = false,
            }
        end,
    },
}
