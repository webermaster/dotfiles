local cmd = vim.cmd
local d = vim.diagnostic
local o = vim.opt
local g = vim.g
local lsp = vim.lsp
local buf = vim.lsp.buf
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

require('mason').setup{
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'hls', 'jdtls', 'jedi_language_server' }
})

local lspconfig = require('lspconfig')
-- python
lspconfig.jedi_language_server.setup({})

-- java
lspconfig.jdtls.setup({})

-- haskell
lspconfig.hls.setup({
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '<space>e', d.open_float)
keymap('n', '[d', d.goto_prev)
keymap('n', ']d', d.goto_next)
keymap('n', '<space>q', d.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    keymap('n', 'gD', buf.declaration, opts)
    keymap('n', 'gd', buf.definition, opts)
    keymap('n', 'K', buf.hover, opts)
    keymap('n', 'gi', buf.implementation, opts)
    keymap('n', '<C-k>', buf.signature_help, opts)
    keymap('n', '<space>wa', buf.add_workspace_folder, opts)
    keymap('n', '<space>wr', buf.remove_workspace_folder, opts)
    keymap('n', '<space>wl', function()
      print(vim.inspect(buf.list_workspace_folders()))
    end, opts)
    keymap('n', '<space>D', buf.type_definition, opts)
    keymap('n', '<space>rn', buf.rename, opts)
    keymap({ 'n', 'v' }, '<space>ca', buf.code_action, opts)
    keymap('n', 'gr', buf.references, opts)
    keymap('n', '<space>f', function()
      buf.format { async = true }
    end, opts)
  end,
})
