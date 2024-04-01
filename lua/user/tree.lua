local M = {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  -- lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

M.config = function()
  require("nvim-tree").setup {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
  }
end

return M
