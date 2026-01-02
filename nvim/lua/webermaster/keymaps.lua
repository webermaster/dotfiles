local keymap = vim.keymap.set

-- Act like D and C
keymap('n', 'Y', 'y$', {})
keymap('n', '<Leader>a', ':cclose<CR>', {})
keymap('n', '<Leader>n', ':cprevious<CR>', {})
keymap('n', '<Leader>m', ':cnext<CR>', {})

-- open terminal
keymap('n', '<Leader>z', ':new<CR>:terminal<CR>', {})
vim.api.nvim_create_autocmd("FileType", {
      pattern = {"go"},
      callback = function(ev)
          -- CTRL/control keymaps
          vim.api
              .nvim_buf_set_keymap(0, "n", "<C-i>", ":GoImport<CR>", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<C-b>", ":GoBuild %:h<CR>",
                                      {})
          vim.api.nvim_buf_set_keymap(0, "n", "<C-t>", ":GoTestPkg<CR>",
                                      {})
          vim.api.nvim_buf_set_keymap(0, "n", "<C-c>",
                                      ":GoCoverage -p<CR>", {})

          -- Opens test files
          vim.api.nvim_buf_set_keymap(0, "n", "A",
                                      ":lua require('go.alternate').switch(true, '')<CR>",
                                      {}) -- Test
          vim.api.nvim_buf_set_keymap(0, "n", "V",
                                      ":lua require('go.alternate').switch(true, 'vsplit')<CR>",
                                      {}) -- Test Vertical
          vim.api.nvim_buf_set_keymap(0, "n", "S",
                                      ":lua require('go.alternate').switch(true, 'split')<CR>",
                                      {}) -- Test Split
      end,
      group = vim.api.nvim_create_augroup("go_autocommands",
                                          {clear = true})
      })
