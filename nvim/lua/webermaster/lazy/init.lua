return {
    'ctrlpvim/ctrlp.vim',
    'SirVer/ultisnips',
    'AndrewRadev/splitjoin.vim',
    {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    },
    'ryanoasis/vim-devicons'
}
