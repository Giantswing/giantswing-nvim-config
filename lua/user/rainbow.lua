local M = {
  "hiphish/rainbow-delimiters.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local rainbow = require("rainbow-delimiters")

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow.strategy["global"],
      },
      blacklist = {
        "comment",
      },
    }
  end,
}

return M
