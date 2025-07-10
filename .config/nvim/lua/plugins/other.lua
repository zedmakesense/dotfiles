return {
    {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
    },

    {
        'mluders/comfy-line-numbers.nvim',
        event = 'VeryLazy',
        opts = {
            number = true,
            relativenumber = true,
            excluded_filetypes = { 'neo-tree', 'NvimTree', 'lazy', 'alpha' },
            threshold = 5,
        },
    },
}
