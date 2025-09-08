vim.loader.enable()
require 'options'
require 'functions'
require 'keymaps'
-- require 'terminal'
require('gruvbox').apply_highlights()
require 'lazy-bootstrap'
require('lazy').setup 'plugins'
require 'autocmds'
