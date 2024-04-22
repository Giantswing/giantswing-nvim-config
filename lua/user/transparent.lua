local M = {
  "xiyaowong/transparent.nvim",
}

M.config = function()
  -- require('transparent').clear_prefix('lualine')
  require('transparent').clear_prefix('treesitter-context')
end

return M
