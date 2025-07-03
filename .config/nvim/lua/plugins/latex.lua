return {
    {
        'lervag/vimtex',
        lazy = false, -- needs to be loaded immediately for filetype detection
        init = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_compiler_latexmk = {
                build_dir = 'build',
                options = {
                    '-pdf',
                    '-interaction=nonstopmode',
                    '-synctex=1',
                },
            }
            -- Optional: Do not open quickfix automatically
            vim.g.vimtex_quickfix_mode = 0
        end,
    },
}
