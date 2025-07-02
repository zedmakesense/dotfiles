return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
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
            auto_install = true,
            indent = { enable = true },
        }
    end,
}
