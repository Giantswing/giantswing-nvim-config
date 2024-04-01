local M = {
  "nvim-lua/plenary.nvim",
}

M.requires = { "nvim-lua/popup.nvim" }

M.config = function()
  require("plenary.reload").reload_module("plenary")
end

return M
