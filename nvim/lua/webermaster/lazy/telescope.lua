return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
          file_ignore_patterns = {
            '.git/',
            '.venv'
          }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-_>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
          local word = vim.fn.expand('<cword>')
          builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
          local word = vim.fn.expand('<cWORD>')
          builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
          builtin.grep_string({ search = vim.fn.input('Grep > ') })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
  }
}
