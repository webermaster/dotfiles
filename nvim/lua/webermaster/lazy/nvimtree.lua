return {
  {
   'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local keymap = vim.keymap.set
      keymap('n', '<Leader>o', ':NvimTreeToggle<CR>', {})
      require('nvim-tree').setup({
         sort = {
           sorter = 'case_sensitive',
         },
         view = {
           width = 30,
         },
         renderer = {
           group_empty = true,
         },
         filters = {
           dotfiles = true,
         },
       })
    end
  }
}

