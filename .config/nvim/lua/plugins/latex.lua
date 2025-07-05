return {
    {
        'lervag/vimtex',
        ft = { 'tex', 'plaintex' },
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
            -- Do not open quickfix automatically
            vim.g.vimtex_quickfix_mode = 0
        end,
    },
}
