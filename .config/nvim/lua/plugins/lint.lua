return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufWritePost' },
    config = function()
        local lint = require 'lint'

        lint.linters_by_ft = {
            python = { 'ruff' },
            markdown = { 'markdownlint' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            css = { 'stylelint' },
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
                if next(vim.lsp.get_clients { bufnr = 0 }) ~= nil then
                    return
                end
                require('lint').try_lint()
            end,
        })
    end,
}
