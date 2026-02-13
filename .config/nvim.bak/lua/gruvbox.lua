local M = {}

function M.apply_highlights()
    local hl = vim.api.nvim_set_hl
    local bg = '#282828' -- main background
    local alt_bg = '#32302f' -- line highlight / alt bg
    local float_bg = '#1d2021' -- floating window bg

    local fg = '#d4be98'
    local grey = '#665c54'
    local red = '#ea6962'
    local green = '#a9b665'
    local yellow = '#d8a657'
    local blue = '#7daea3'
    local purple = '#d3869b'
    local aqua = '#89b482'
    local orange = '#e78a4e'
    local comment = '#928374'
    local softline = '#3a3a3a'

    -- Core UI
    hl(0, 'Normal', { fg = fg, bg = bg })
    hl(0, 'NormalNC', { bg = bg })
    hl(0, 'EndOfBuffer', { fg = bg, bg = bg })
    hl(0, 'CursorLine', { bg = alt_bg })
    hl(0, 'ColorColumn', { bg = softline })
    hl(0, 'CursorLineNr', { fg = yellow, bg = bg, bold = true })
    hl(0, 'LineNr', { fg = grey, bg = bg })
    hl(0, 'LineNrAbove', { fg = grey, bg = bg })
    hl(0, 'LineNrBelow', { fg = grey, bg = bg })
    hl(0, 'SignColumn', { fg = grey, bg = bg })
    hl(0, 'FoldColumn', { bg = bg })
    hl(0, 'VertSplit', { fg = alt_bg, bg = bg })
    hl(0, 'WinSeparator', { fg = alt_bg, bg = bg })
    hl(0, 'MsgArea', { bg = bg })
    hl(0, 'MsgSeparator', { bg = bg })

    -- StatusLine
    hl(0, 'StatusLine', { fg = '#bdae93', bg = bg })
    hl(0, 'StatusLineNC', { fg = grey, bg = bg })

    -- Floating windows
    hl(0, 'NormalFloat', { bg = float_bg })
    hl(0, 'FloatBorder', { fg = '#bdae93', bg = float_bg })
    hl(0, 'FloatTitle', { fg = yellow, bg = float_bg })

    -- Popup menu
    hl(0, 'Pmenu', { fg = fg, bg = alt_bg })
    hl(0, 'PmenuSel', { fg = '#ebdbb2', bg = '#504945' })
    hl(0, 'PmenuSbar', { bg = alt_bg })
    hl(0, 'PmenuThumb', { bg = grey })

    -- Syntax
    hl(0, 'Comment', { fg = comment, italic = true })
    hl(0, 'Function', { fg = yellow, bold = true })
    hl(0, 'Keyword', { fg = purple, italic = true })
    hl(0, 'Type', { fg = aqua, italic = true })
    hl(0, '@variable', { fg = fg })
    hl(0, '@function', { fg = yellow, bold = true })
    hl(0, '@keyword', { fg = purple, italic = true })
    hl(0, '@string', { fg = green })
    hl(0, '@comment', { fg = comment, italic = true })
    hl(0, '@number', { fg = purple })
    hl(0, '@boolean', { fg = red })
    hl(0, '@type', { fg = aqua })
    hl(0, '@lsp.type.function', { link = '@function' })
    hl(0, '@lsp.type.variable', { link = '@variable' })
    hl(0, '@lsp.typemod.variable.readonly', { italic = true })

    -- GitSigns
    hl(0, 'GitSignsAdd', { fg = green })
    hl(0, 'GitSignsChange', { fg = yellow })
    hl(0, 'GitSignsDelete', { fg = red })

    -- Diagnostics (LSP)
    hl(0, 'DiagnosticError', { fg = red })
    hl(0, 'DiagnosticWarn', { fg = orange })
    hl(0, 'DiagnosticInfo', { fg = blue })
    hl(0, 'DiagnosticHint', { fg = aqua })

    hl(0, 'DiagnosticFloatingError', { fg = red, bg = float_bg })
    hl(0, 'DiagnosticFloatingWarn', { fg = orange, bg = float_bg })
    hl(0, 'DiagnosticFloatingInfo', { fg = blue, bg = float_bg })
    hl(0, 'DiagnosticFloatingHint', { fg = aqua, bg = float_bg })

    hl(0, 'DiagnosticVirtualTextError', { fg = red, bg = bg })
    hl(0, 'DiagnosticVirtualTextWarn', { fg = orange, bg = bg })
    hl(0, 'DiagnosticVirtualTextInfo', { fg = blue, bg = bg })
    hl(0, 'DiagnosticVirtualTextHint', { fg = aqua, bg = bg })

    hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = red })
    hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = orange })
    hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = blue })
    hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = aqua })

    hl(0, 'DiagnosticSignError', { fg = red, bg = bg })
    hl(0, 'DiagnosticSignWarn', { fg = orange, bg = bg })
    hl(0, 'DiagnosticSignInfo', { fg = blue, bg = bg })
    hl(0, 'DiagnosticSignHint', { fg = aqua, bg = bg })
end

return M
