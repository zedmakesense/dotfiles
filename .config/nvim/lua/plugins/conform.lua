return {
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
            python = { 'black' },
            sh = { 'shfmt' },
            javascript = { 'prettierd' },
            javascriptreact = { 'prettierd' },
            css = { 'prettierd' },
            tex = { 'tex-fmt' },
            plaintex = { 'tex-fmt' },
            markdown = { 'markdownlint' },
            java = { 'google-java-format' },
            go = { 'gofumpt', 'goimports' },
        },
    },
}
