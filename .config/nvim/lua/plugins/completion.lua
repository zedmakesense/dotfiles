return {
    {
        'L3MON4D3/LuaSnip',
        event = { 'InsertEnter', 'CmdlineEnter' },
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },
    {
        'saghen/blink.cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        version = '1.*',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind.nvim',
        },
        opts = {
            keymap = {
                preset = 'default',
            },
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
                documentation = {
                    auto_show = false,
                    auto_show_delay_ms = 500,
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
    },
}
