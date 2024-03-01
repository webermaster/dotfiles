return {
    {
      'hashivim/vim-terraform',
      config = function()
        -- VIM-TERRAFORM
        vim.g.terraform_fmt_on_save = 1
      end
    },
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
