return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd("colorscheme rose-pine-moon")
    end
  }
}
