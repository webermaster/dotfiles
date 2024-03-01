return {
  {
    'preservim/tagbar',
    config = function()
        -- TAGBAR settings
        vim.keymap.set('n', '<Leader>p', ':TagbarToggle<CR>', {})
        vim.g.tagbar_show_linenumbers = 2
    end
  }
}
