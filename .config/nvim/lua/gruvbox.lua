local M = {}

function M.apply_highlights()
    local hl = vim.api.nvim_set_hl
    local bg = '#282828'
    local alt_bg = '#32302f'

    hl(0, 'Comment', { fg = '#928374', italic = true })

    -- Diagnostics
    hl(0, 'DiagnosticError', { fg = '#ea6962' })
    hl(0, 'DiagnosticWarn', { fg = '#e78a4e' })
    hl(0, 'DiagnosticInfo', { fg = '#7daea3' })
    hl(0, 'DiagnosticHint', { fg = '#89b482' })

    -- GitSigns
    hl(0, 'GitSignsAdd', { fg = '#a9b665' })
    hl(0, 'GitSignsChange', { fg = '#d8a657' })
    hl(0, 'GitSignsDelete', { fg = '#ea6962' })

    -- Syntax
    hl(0, 'Function', { fg = '#d8a657', bold = true })
    hl(0, 'Keyword', { fg = '#d3869b', italic = true })
    hl(0, 'Type', { fg = '#89b482', italic = true })
    hl(0, '@variable', { fg = '#d4be98' })
    hl(0, '@function', { fg = '#d8a657', bold = true })
    hl(0, '@keyword', { fg = '#d3869b', italic = true })
    hl(0, '@string', { fg = '#a9b665' })
    hl(0, '@comment', { fg = '#928374', italic = true })
    hl(0, '@number', { fg = '#d3869b' })
    hl(0, '@boolean', { fg = '#ea6962' })
    hl(0, '@type', { fg = '#89b482' })
    hl(0, '@lsp.type.function', { link = '@function' })
    hl(0, '@lsp.type.variable', { link = '@variable' })
    hl(0, '@lsp.typemod.variable.readonly', { italic = true })

    -- UI
    hl(0, 'Normal', { fg = '#d4be98', bg = bg })
    hl(0, 'NormalNC', { bg = bg })
    hl(0, 'EndOfBuffer', { fg = bg, bg = bg })
    hl(0, 'MsgArea', { bg = bg })
    hl(0, 'MsgSeparator', { bg = bg })

    -- Statusline
    hl(0, 'StatusLine', { fg = '#bdae93', bg = bg })
    hl(0, 'StatusLineNC', { fg = '#665c54', bg = bg })

    -- Popup menu
    hl(0, 'Pmenu', { bg = alt_bg, fg = '#d4be98' })
    hl(0, 'PmenuSel', { bg = '#504945', fg = '#ebdbb2' })
    hl(0, 'PmenuSbar', { bg = alt_bg })
    hl(0, 'PmenuThumb', { bg = '#665c54' })

    -- Floating windows
    hl(0, 'NormalFloat', { bg = bg })
    hl(0, 'FloatBorder', { fg = '#bdae93', bg = bg })
    hl(0, 'FloatTitle', { fg = '#d8a657', bg = bg })

    -- Line numbers & side columns
    hl(0, 'LineNr', { fg = '#665c54', bg = bg })
    hl(0, 'CursorLineNr', { fg = '#d8a657', bg = bg, bold = true })
    hl(0, 'SignColumn', { fg = '#665c54', bg = bg })
    hl(0, 'FoldColumn', { bg = bg })
    hl(0, 'LineNrAbove', { bg = bg })
    hl(0, 'LineNrBelow', { bg = bg })

    -- Window borders / splits
    hl(0, 'VertSplit', { fg = alt_bg, bg = bg })
    hl(0, 'WinSeparator', { fg = alt_bg, bg = bg })

    -- Cursor line
    hl(0, 'CursorLine', { bg = alt_bg, blend = 0 })

    -- Right column
    hl(0, 'ColorColumn', { bg = bg })
end

return M
