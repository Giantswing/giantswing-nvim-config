local M = {
  "chentoast/marks.nvim",
}

M.config = function()
  require("marks").setup {
    mappings = {
      set_next = "mm",
      next = "<leader>m",
    }
  }
end

return M
