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

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')
-- python
lspconfig.jedi_language_server.setup({
  capabilities = cpapbilities
})

-- java
lspconfig.jdtls.setup({
  capabilities = cpapbilities
})

-- haskell
lspconfig.hls.setup({
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  capabilities = cpapbilities
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
