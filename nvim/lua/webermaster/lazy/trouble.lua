return {
  {
    "folke/trouble.nvim",
    config = function(_, opts)
      local trouble = require("trouble")

      trouble.setup(opts)

      -- Toggle document diagnostics
      vim.keymap.set("n", "<leader>tt", function()
        trouble.toggle("diagnostics")
      end, { desc = "Toggle Trouble diagnostics" })

      -- Workspace diagnostics
      vim.keymap.set("n", "<leader>tT", function()
        trouble.toggle("diagnostics", { mode = "workspace" })
      end, { desc = "Toggle Trouble workspace diagnostics" })

      -- Quickfix list
      vim.keymap.set("n", "<leader>tq", function()
        trouble.toggle("quickfix")
      end, { desc = "Toggle Trouble quickfix" })

      -- Location list
      vim.keymap.set("n", "<leader>tl", function()
        trouble.toggle("loclist")
      end, { desc = "Toggle Trouble loclist" })

      vim.keymap.set("n", "]t", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "[t", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

    end
  }
}

