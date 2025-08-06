vim.loader.enable()
require 'options'
require 'functions'
require 'keymaps'
-- require 'terminal'
require('gruvbox').apply_highlights()
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local cmd = {
        'git', 'clone', '--filter=blob:none',
        '--branch=stable', lazyrepo, lazypath
    }
    local result = vim.fn.system(cmd)
    print("Cloning lazy.nvim: " .. result)
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup 'plugins'
require 'autocmds'
