vim.loader.enable()
require 'options'
require 'functions'
require 'keymaps'
require 'terminal'
require('gruvbox').apply_highlights()
require 'lazy-bootstrap'
require('lazy').setup {
    spec = {
        { import = 'plugins' },
    },
    -- performance updates
    checker = {
        enabled = true, -- Check updates silently (Options: true, false)
        notify = false, -- Disable notification when checking (Options: true, false)
    },
    change_detection = {
        notify = false, -- Don't spam notifications on config change (Options: true, false)
    },
    rocks = {
        enabled = false,
        hererocks = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                '2html_plugin',
                'getscript',
                'getscriptPlugin',
                'gzip',
                'logipat',
                'matchit',
                'netrw',
                'tohtml',
                'netrwFileHandlers',
                'loaded_remote_plugins',
                'loaded_tutor_mode_plugin',
                'netrwPlugin',
                'netrwSettings',
                'rrhelper',
                -- 'man',
                'spellfile',
                'tar',
                'tarPlugin',
                'vimball',
                'vimballPlugin',
                'zip',
                'tutor',
                'rplugin',
                'zipPlugin',
            },
        },
    },
}
require 'autocmds'
