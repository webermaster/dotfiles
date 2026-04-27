return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
		init = function()
			local parsers = {
        'c',
        'bash',
        'haskell',
        'go',
        'lua',
        'java',
        'python',
        'terraform',
        'query',
        'rust',
        'vim',
        'vimdoc',
        'yaml'
      }

			local group = vim.api.nvim_create_augroup('WebermasterTreesitter', { clear = true })
			vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
				group = group,
				callback = function()
					if vim.bo.buftype ~= '' then
						return
					end

					pcall(vim.treesitter.start, 0)
				end,
			})

			vim.api.nvim_create_autocmd('User', {
				group = group,
				pattern = 'VeryLazy',
				once = true,
				callback = function()
					require('nvim-treesitter').install(parsers)
				end,
			})
		end,
	}
}
