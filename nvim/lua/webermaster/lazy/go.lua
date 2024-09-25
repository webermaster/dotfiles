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
      local augroup = vim.api.nvim_create_autocmd
      local go_grp = vim.api.nvim_create_augroup('go', {})
      augroup({'BufWritePre'}, {
        pattern = '*.go',
        callback = function()
         require('go.format').goimport()
        end,
        group = go_grp,
      })
      local keymap = vim.keymap.set
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      local GoGroup = augroup('Go', {})
    end,
    event = {'CmdlineEnter'},
    ft = {'go', 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
