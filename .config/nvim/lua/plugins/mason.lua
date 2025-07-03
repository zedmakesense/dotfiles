return {
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-lspconfig').setup {
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
                    'ltex_plus',
                },
            }
        end,
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'ruff',
                    'stylua',
                    'prettier',
                    'prettierd',
                    'shfmt',
                    'markdownlint',
                },
                automatic_installation = true,
            }
        end,
    },
}
