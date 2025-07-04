return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufWritePost' },
    config = function()
        local lint = require 'lint'

        lint.linters_by_ft = {
            python = { 'ruff' },
            lua = { 'luacheck' },
            sh = { 'shellcheck' },
            markdown = { 'markdownlint' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            css = { 'stylelint' },
        }

        -- auto lint on save and on buffer read
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
