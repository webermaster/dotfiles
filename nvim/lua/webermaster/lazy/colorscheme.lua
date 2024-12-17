return {
    {
      'briones-gabriel/darcula-solid.nvim',
      dependencies = {
        'rktjmp/lush.nvim',
      },
      config = function()
        -- require('tokyonight').setup({
        -- })
        vim.o.background = 'dark'
        vim.cmd[[colorscheme darcula-solid]]
      end
    }
}
