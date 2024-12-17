return {
    {
      'ellisonleao/gruvbox.nvim',
      config = function()
        -- require('tokyonight').setup({
        -- })
        vim.o.background = 'dark'
        vim.cmd[[colorscheme gruvbox]]
      end
    }
}
