return {
    'sainnhe/gruvbox-material',
    lazy = false,
    event = 'ColorSchemePre',
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme 'gruvbox-material'
    end,
}
