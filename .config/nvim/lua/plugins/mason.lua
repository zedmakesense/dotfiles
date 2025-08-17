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
                    'marksman',
                    'texlab',
                    'ruff',
                    'black',
                    'stylua',
                    'prettierd',
                    'shfmt',
                    'markdownlint',
                    'shellcheck',
                    'eslint_d',
                    'stylelint',
                    'tex-fmt',
                    'jdtls',
                    'google-java-format',
                },
                automatic_installation = false,
            }
        end,
    },
}
