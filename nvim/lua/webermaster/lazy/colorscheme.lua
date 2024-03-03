return {
    {
      'folke/tokyonight.nvim',
      config = function()
        require('tokyonight').setup({
        })
        vim.o.background = 'dark'
        vim.cmd[[colorscheme tokyonight-night]]
      end
    }
}
