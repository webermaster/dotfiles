return {
    {
      'github/copilot.vim',
      config = function()
        vim.g.copilot_filetypes = {
          ['*'] = false
        }
      end
    },
    'ctrlpvim/ctrlp.vim',
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    },
    'ryanoasis/vim-devicons'
}
