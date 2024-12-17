return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'j-hui/fidget.nvim'
    },
    config = function()
      local d = vim.diagnostic
      local buf = vim.lsp.buf
      local autocmd = vim.api.nvim_create_autocmd
      local keymap = vim.keymap.set


      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          cmp_lsp.default_capabilities())

      require("fidget").setup({})
      require('mason').setup{
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      }

      require('mason-lspconfig').setup({
        -- A list of servers to automatically install if they're not already installed
        ensure_installed = {
          'gopls',
          'jdtls',
          'jedi_language_server',
          'lua_ls',
          'rust_analyzer'
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end,
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" }
                  }
                }
              }
            }
          end
        }

      })

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-m>'] = cmp.mapping.select_next_item(cmp_select),
          ["<C-Space>"] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true })
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
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


      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      keymap('n', '<leader>vd', d.open_float)
      keymap('n', '[d', d.goto_prev)
      keymap('n', ']d', d.goto_next)
      keymap('n', '<leader>vq', d.setloclist)

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
          keymap('n', 'gd', buf.definition, opts)
          keymap('n', 'gD', buf.declaration, opts)
          keymap('n', 'gi', buf.implementation, opts)
          keymap('n', 'gr', buf.references, opts)
          keymap('n', 'gtd', buf.type_definition, opts)
          keymap('n', 'K', buf.hover, opts)
          keymap("i", "<C-h>", buf.signature_help, opts)
          keymap({ 'n', 'v' }, '<leader>vca', buf.code_action, opts)
          keymap('n', '<leader>vf', function()
            buf.format { async = true }
          end, opts)
          keymap('n', '<leader>vrn', buf.rename, opts)
          keymap('n', '<leader>vwa', buf.add_workspace_folder, opts)
          keymap('n', '<leader>vwl', function()
            print(vim.inspect(buf.list_workspace_folders()))
          end, opts)
          keymap('n', '<leader>vwr', buf.remove_workspace_folder, opts)
          keymap("n", "<leader>vws", buf.workspace_symbol, opts)
        end,
      })
    end


  }
}
