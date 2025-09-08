return {
    {
        'mason-org/mason.nvim',
        event = 'VeryLazy',
        build = ':MasonUpdate',
        config = true,
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        cmd = { 'MasonToolsInstall' },
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'pyright',
                    'bash-language-server',
                    'html-lsp',
                    'json-lsp',
                    'css-lsp',
                    'typescript-language-server',
                    'lua-language-server',
                    'texlab',
                    'ruff',
                    'black',
                    'stylua',
                    'prettierd',
                    'shfmt',
                    'shellcheck',
                    'eslint_d',
                    'stylelint',
                    'tex-fmt',
                    'jdtls',
                    'google-java-format',
                    'gofumpt',
                    'goimports',
                    'gopls',
                },
                automatic_installation = false,
            }
        end,
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        cmd = { 'DapInstall' },
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-nvim-dap').setup {
                ensure_installed = { 'delve', 'debugpy', 'java-debug-adapter', 'bash-debug-adapter' },
                automatic_installation = false,
            }
        end,
    },
}
