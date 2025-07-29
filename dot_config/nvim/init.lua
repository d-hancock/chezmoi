-- ===================================================================
-- Neovim Configuration (init.lua)
-- ===================================================================
-- This file configures Neovim for a modern development environment
-- Applied to ~/.config/nvim/init.lua by ChezMoi
-- Neovim-specific configuration with Lua

-- ===================================================================
-- General Settings
-- ===================================================================
vim.opt.compatible = false           -- Disable Vi compatibility (Neovim default)
vim.opt.encoding = 'utf-8'           -- Use UTF-8 encoding
vim.opt.fileencoding = 'utf-8'       -- Set file encoding to UTF-8
vim.opt.backspace = {'indent', 'eol', 'start'} -- Allow backspace over everything
vim.opt.hidden = true                -- Allow switching buffers without saving
vim.opt.autoread = true              -- Auto-reload files changed outside nvim
vim.opt.mouse = 'a'                  -- Enable mouse support in all modes

-- ===================================================================
-- Display and Interface
-- ===================================================================
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.ruler = true                 -- Show cursor position in status line
vim.opt.showcmd = true               -- Show incomplete commands
vim.opt.showmode = true              -- Show current mode
vim.opt.wildmenu = true              -- Enhanced command completion
vim.opt.wildmode = {'longest:full', 'full'} -- Command completion behavior
vim.opt.laststatus = 2               -- Always show status line
vim.opt.cmdheight = 2                -- Give more space for displaying messages
vim.opt.signcolumn = 'yes'           -- Always show sign column
vim.opt.colorcolumn = {'80', '120'}  -- Show column guidelines
vim.opt.cursorline = true            -- Highlight current line
vim.opt.wrap = false                 -- Don't wrap lines by default

-- ===================================================================
-- Search and Navigation
-- ===================================================================
vim.opt.hlsearch = true              -- Highlight search results
vim.opt.incsearch = true             -- Incremental search
vim.opt.ignorecase = true            -- Case insensitive search
vim.opt.smartcase = true             -- Case sensitive if uppercase present
vim.opt.wrapscan = true              -- Wrap around when searching
vim.opt.gdefault = true              -- Global replace by default

-- ===================================================================
-- Indentation and Formatting
-- ===================================================================
vim.opt.autoindent = true            -- Auto-indent new lines
vim.opt.smartindent = true           -- Smart indenting
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.tabstop = 4                  -- Tab width = 4 spaces
vim.opt.shiftwidth = 4               -- Indent width = 4 spaces
vim.opt.softtabstop = 4              -- Soft tab width = 4 spaces
vim.opt.shiftround = true            -- Round indent to multiple of shiftwidth

-- ===================================================================
-- File and Buffer Management
-- ===================================================================
vim.opt.backup = true                -- Keep backup files
vim.opt.backupdir = vim.fn.expand('~/.config/nvim/backup//')
vim.opt.directory = vim.fn.expand('~/.config/nvim/swap//')
vim.opt.undofile = true              -- Enable persistent undo
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undo//')
vim.opt.history = 1000               -- Command history size
vim.opt.undolevels = 1000            -- Maximum number of undos

-- Create directories if they don't exist
local function ensure_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, 'p', 0700)
    end
end

ensure_dir(vim.fn.expand('~/.config/nvim/backup'))
ensure_dir(vim.fn.expand('~/.config/nvim/swap'))
ensure_dir(vim.fn.expand('~/.config/nvim/undo'))

-- ===================================================================
-- Colors and Syntax
-- ===================================================================
vim.opt.syntax = 'on'                -- Enable syntax highlighting
vim.opt.background = 'dark'          -- Dark background
vim.opt.termguicolors = true         -- Enable true color support

-- Use a modern colorscheme if available, fallback to default
pcall(vim.cmd, 'colorscheme habamax')

-- ===================================================================
-- Key Mappings
-- ===================================================================
-- Set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Quick save and quit
vim.keymap.set('n', '<leader>w', ':w<CR>', {desc = 'Save file'})
vim.keymap.set('n', '<leader>q', ':q<CR>', {desc = 'Quit'})
vim.keymap.set('n', '<leader>x', ':x<CR>', {desc = 'Save and quit'})
vim.keymap.set('n', '<leader>Q', ':q!<CR>', {desc = 'Force quit'})

-- Clear search highlighting
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>', {desc = 'Clear search highlight'})

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', {desc = 'Next buffer'})
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', {desc = 'Previous buffer'})
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', {desc = 'Delete buffer'})

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', {desc = 'Move to left split'})
vim.keymap.set('n', '<C-j>', '<C-w>j', {desc = 'Move to bottom split'})
vim.keymap.set('n', '<C-k>', '<C-w>k', {desc = 'Move to top split'})
vim.keymap.set('n', '<C-l>', '<C-w>l', {desc = 'Move to right split'})

-- Split resizing
vim.keymap.set('n', '<leader>+', ':resize +5<CR>', {desc = 'Increase height'})
vim.keymap.set('n', '<leader>-', ':resize -5<CR>', {desc = 'Decrease height'})
vim.keymap.set('n', '<leader><', ':vertical resize -5<CR>', {desc = 'Decrease width'})
vim.keymap.set('n', '<leader>>', ':vertical resize +5<CR>', {desc = 'Increase width'})

-- Toggle relative line numbers
vim.keymap.set('n', '<leader>n', ':set relativenumber!<CR>', {desc = 'Toggle relative numbers'})

-- Quick edit config
vim.keymap.set('n', '<leader>ev', ':edit $MYVIMRC<CR>', {desc = 'Edit config'})
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>', {desc = 'Reload config'})

-- Terminal mode key mappings
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = 'Exit terminal mode'})
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', {desc = 'Terminal: move left'})
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', {desc = 'Terminal: move down'})
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', {desc = 'Terminal: move up'})
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', {desc = 'Terminal: move right'})

-- Visual mode mappings
vim.keymap.set('v', '.', ':norm.<CR>', {desc = 'Repeat last normal command on selection'})
-- ===================================================================
-- File Type Specific Settings
-- ===================================================================
-- Enable filetype detection and plugins
vim.cmd('filetype plugin indent on')

-- Create autocommand group for file type settings
local augroup = vim.api.nvim_create_augroup('FileTypeSettings', {clear = true})

-- YAML files
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'yaml',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- JSON files
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'json',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- Markdown files
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'markdown',
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.list = false
        vim.opt_local.textwidth = 80
    end,
})

-- Python files
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'python',
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.textwidth = 88
    end,
})

-- Shell scripts
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'sh',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- ===================================================================
-- Status Line
-- ===================================================================
-- Simple custom status line
function _G.custom_statusline()
    local parts = {
        '%f',           -- File path
        '%m',           -- Modified flag
        '%r',           -- Read-only flag
        '%h',           -- Help flag
        '%w',           -- Preview flag
        '%=',           -- Right align
        ' %y',          -- File type
        ' %{&encoding}', -- Encoding
        ' %{&ff}',      -- File format
        ' %l:%c',       -- Line:Column
        ' %P'           -- Percentage through file
    }
    return table.concat(parts, '')
end

vim.opt.statusline = '%{v:lua.custom_statusline()}'

-- ===================================================================
-- Performance and Behavior
-- ===================================================================
vim.opt.updatetime = 300             -- Faster completion
vim.opt.timeoutlen = 500             -- Faster key sequence timeout
vim.opt.ttimeoutlen = 10             -- Faster escape key response
vim.opt.scrolloff = 8                -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8            -- Keep 8 columns visible left/right
vim.opt.lazyredraw = true            -- Don't redraw during macros

-- ===================================================================
-- Clipboard Integration
-- ===================================================================
-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- ===================================================================
-- Modern Neovim Features
-- ===================================================================
-- Enable built-in LSP client highlighting
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspHighlight', {clear = true}),
    callback = function(ev)
        -- Highlight references under cursor
        if vim.bo[ev.buf].filetype ~= 'oil' then
            vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
                buffer = ev.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = ev.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- ===================================================================
-- Terminal Integration
-- ===================================================================
-- Better terminal integration
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
    end,
})

-- ===================================================================
-- Local Customizations
-- ===================================================================
-- Load local config if it exists (for machine-specific settings)
local local_config = vim.fn.expand('~/.config/nvim/local.lua')
if vim.fn.filereadable(local_config) == 1 then
    dofile(local_config)
end
