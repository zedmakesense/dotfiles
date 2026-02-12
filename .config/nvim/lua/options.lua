-- Leader Key Setup
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Statusline
vim.o.statusline = table.concat {
    '%#Normal#',
    ' %F',
    ' %h%w%m%r',
    '%=',
    '%l/%L',
}

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = { 'en_us'}
-- Netrw Configuration
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

-- UI Configuration
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.pumheight = 10 -- Maximum number of items in popup menu
-- vim.opt.cmdheight = 0

-- Editor Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.timeoutlen = 500 -- Time (ms) to wait for a mapped sequence to complete
vim.opt.updatetime = 300 -- Debounce time for completion (default 4000)
vim.opt.completeopt = { -- Options for Insert mode completion
    'menuone', -- Show popup even if there is only one match
    'noselect', -- Do not select a match in the menu automatically
}
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.wrap = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.confirm = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.path:append '**' -- include subdirectories in search

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = true -- create temporary backup while writing
vim.opt.swapfile = true -- enable swap files for crash recovery

-- Place swap files in a single state directory (double-slash allows nested filenames)
local swapdir = vim.fn.stdpath 'state' .. '/swap//'
if vim.fn.isdirectory(swapdir) == 0 then
    vim.fn.mkdir(swapdir, 'p')
end
vim.opt.directory = swapdir

-- Undo
local undodir = vim.fn.stdpath 'cache' .. '/undo'

if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line
-- vim.opt.colorcolumn = '80' -- vertical line

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Minimal Neovim for quick editing (aggressive disable)

-- Disable built-in plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "matchparen",
  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "spellfile",
  "tar",
  "tarPlugin",
  "tohtml",
  "tutor",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "rplugin",
  "syntax",         -- disable if you truly don't need highlighting
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",       -- disables filetype plugins
  "editorconfig",   -- if present
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Disable language providers (big startup win)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable filetype detection completely (optional, extreme minimal)
-- Uncomment if you truly want zero language logic
vim.g.did_load_filetypes = 1
-- Core minimal setting
vim.opt.modeline = false
vim.opt.foldenable = false
vim.opt.spell = false
vim.opt.syntax = "OFF"