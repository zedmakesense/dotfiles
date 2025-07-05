return {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'bash',
                'python',
                'c',
                'cpp',
                'diff',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
        }
    end,
}
