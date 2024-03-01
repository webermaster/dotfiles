return {
    'uarun/vim-protobuf',
    'SirVer/ultisnips',
    'AndrewRadev/splitjoin.vim', 
    { 
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    },
    'tpope/vim-fugitive', 
    'ryanoasis/vim-devicons',
    'ctrlpvim/ctrlp.vim'
}
