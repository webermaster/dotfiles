return {
  {
    'ray-x/go.nvim',
    dependencies = {  -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      local go_grp = augroup('go', {})
      autocmd({'BufWritePre'}, {
        pattern = 'go',
        callback = function()
         require('go.format').goimport()
        end,
        group = go_grp,
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>b :GoBuild<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>g :GoRun<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>t :GoTest<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>c :GoCoverage<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>i :GoImpl<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>d :GoDoc<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>s :GoAltV<CR>'
      })
      autocmd({'FileType'}, {
        pattern = 'go',
        command = 'nmap <leader>f :GoIfErr<CR>'
      })
    end,
    event = {'CmdlineEnter'},
    ft = {'go', 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
