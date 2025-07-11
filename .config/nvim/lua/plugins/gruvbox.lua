return {
    'echasnovski/mini.base16',
    version = '*',
    event = { 'BufReadPost', 'BufWritePost' },
    config = function()
        require('mini.base16').setup {
            palette = {
                base00 = '#282828', -- bg
                base01 = '#32302f', -- bg1
                base02 = '#3c3836', -- bg2
                base03 = '#504945', -- bg3
                base04 = '#665c54', -- bg4
                base05 = '#d4be98', -- fg
                base06 = '#ddc7a1', -- fg1
                base07 = '#ebdbb2', -- fg2
                base08 = '#ea6962', -- red
                base09 = '#e78a4e', -- orange
                base0A = '#d8a657', -- yellow
                base0B = '#a9b665', -- green
                base0C = '#89b482', -- aqua
                base0D = '#7daea3', -- blue
                base0E = '#d3869b', -- purple
                base0F = '#bd6f3e', -- brown
            },
            use_cterm = true,
        }
        require('gruvbox').apply_highlights()
    end,
}
