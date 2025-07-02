return {
    { 'mbbill/undotree' },
    {
        'rmagatti/goto-preview',
        dependencies = { 'rmagatti/logger.nvim' },
        event = 'BufEnter',
        config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
}
