if vim.loader then vim.loader.enable() end

vim.cmd('syntax on')
vim.g.did_load_filetypes = nil
vim.cmd('filetype plugin indent on')

do
  local hl = vim.api.nvim_set_hl
  local bg, alt_bg = '#282828', '#32302f'
  local fg, grey = '#d4be98', '#665c54'
  local yellow, purple, green = '#d8a657', '#d3869b', '#a9b665'
  local comment = '#928374'

  hl(0, 'Normal',       { fg = fg, bg = bg })
  hl(0, 'EndOfBuffer',  { fg = bg, bg = bg })
  hl(0, 'CursorLine',   { bg = alt_bg })
  hl(0, 'LineNr',       { fg = grey, bg = bg })
  hl(0, 'CursorLineNr', { fg = yellow, bg = bg, bold = true })
  hl(0, 'VertSplit',    { fg = alt_bg, bg = bg })
  hl(0, 'StatusLine',   { fg = fg, bg = bg })
  hl(0, 'StatusLineNC', { fg = grey, bg = bg })

  hl(0, 'Comment',  { fg = comment, italic = true })
  hl(0, 'String',   { fg = green })
  hl(0, 'Keyword',  { fg = purple, italic = true })
  hl(0, 'Function', { fg = yellow, bold = true })
  hl(0, 'Type',     { fg = purple })
end

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.statusline = table.concat {
  '%#Normal#', ' %F', ' %h%w%m%r', '%=', '%l/%L',
}

local o = vim.opt
o.termguicolors = true
o.background = 'dark'
o.pumheight = 10
o.number = true
o.relativenumber = true
o.cursorline = false
o.signcolumn = 'no'
o.scrolloff = 8
o.sidescrolloff = 8
o.splitright = true
o.splitbelow = true
o.wrap = true
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.mouse = 'a'
o.breakindent = true
o.ignorecase = true
o.smartcase = true
o.timeoutlen = 500
o.updatetime = 300
vim.o.completeopt = "menu,menuone,noselect"
o.confirm = true
o.lazyredraw = true
o.path:append('**')

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true
o.autoindent = true

o.backup = false
o.writebackup = true
o.swapfile = true

local state_swap = vim.fn.stdpath('state') .. '/swap//'
if vim.fn.isdirectory(state_swap) == 0 then vim.fn.mkdir(state_swap, 'p') end
o.directory = state_swap

local undodir = vim.fn.stdpath('cache') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, 'p') end
o.undodir = undodir
o.undofile = true

o.redrawtime = 10000
o.maxmempattern = 20000
o.synmaxcol = 300

o.foldenable = false
o.modeline = false
o.spell = false
vim.g.spelllang = 'en_us'
vim.keymap.set('n', '<leader>s', ':set spell!<CR>', { silent = true })

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

o.shortmess:append('c')

local disabled_builtins = {
  "2html_plugin","getscript","getscriptPlugin","gzip","logipat",
  "matchit","matchparen","rrhelper","tarPlugin","tohtml",
  "tutor","vimballPlugin","zipPlugin","rplugin",
}
for _, v in ipairs(disabled_builtins) do vim.g["loaded_" .. v] = 1 end

local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>')
map('n', 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true, silent = true })
map('n', 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true, silent = true })
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', '<', '<gv')
map('v', '>', '>gv')
map({ 'n','i' }, '<C-s>', '<CMD>w<CR>')
map({ 'n','x','v' }, 'gy', '"+y')
map({ 'n','x','v' }, 'gp', '"+p')

local aug = vim.api.nvim_create_augroup('UserConfig', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = aug,
  callback = function() vim.highlight.on_yank { timeout = 120 } end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = aug,
  pattern = '*',
  callback = function() vim.cmd [[%s/\s\+$//e]] end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    group = autocmd,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})


