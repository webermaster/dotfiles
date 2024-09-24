
local o = vim.opt
local g = vim.g

o.compatible = false                      -- Don't care about compatibility with old vi
o.autoread = true                         -- Automatically read changed files
o.number = true                           -- Set line numbers
o.wrap = false                            -- Don't wrap lines
o.laststatus = 2                          -- Show status line always
o.tabstop = 4                             -- Tab is 4 spaces
o.softtabstop = 4                         -- Tab is 4 space when inserting
o.expandtab = true                        -- On pressing tab, insert 4 spaces
o.backspace = {'indent','eol','start'}    -- Allow backspacing over everything in insert
o.autoindent = true                       -- Always set autoindenting on
o.smartindent = true                      -- Asmart autoindenting when starting a new line
o.copyindent = true                       -- Copy previous indentation on autoindenting
o.shiftwidth = 4                          -- Number of spaces to use for autoindenting
o.showmatch = true                        -- Show matching parentheses
o.smartcase = true                        -- Ignore case if search pattern is all lowercase, case-sensitive otherwise
o.hlsearch = true                         -- Highlight search terms
o.incsearch = true                        -- Show search matches as you type
o.splitright = true                       -- Vsplit opens to the right
o.splitbelow = true                       -- Horizontal windows should split to bottom
o.showmode = false                        -- We show the mode with airline or lightline
o.completeopt = {'menu', 'menuone'}       -- Show popup menu, even if there is one entry
o.mouse = 'a'                             -- Enable mouse for all modes
o.encoding = 'utf-8'                      -- UTF-8 encoding
o.showtabline = 2                         -- always show tabline
o.hidden = false                          -- disable hidden buffers
o.termguicolors = true                    -- optionally enable 24-bit colour


g.loaded_netrw = 1                        -- disable netrw at the very start of your init.lua
g.loaded_netrwPlugin = 1                  -- disable netrw at the very start of your init.lua
g.python3_host_prog = vim.fn.expand('~') .. '/.config/nvim/.venv/bin/python3'
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
