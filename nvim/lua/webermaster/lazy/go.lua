return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("go").setup({
        -- This replaces the need for a manual autocmd
        lsp_cfg = true,
        lsp_gofmt = true, -- runs gofmt on save
        goimport = "goimports", -- runs goimports on save
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", "gomod"},
    build = ':lua require("go.install").update_all_sync()'
  }
}
