local M = {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat"}
}

function M.config()
  local leap = require("leap")
  leap.create_default_mappings()
end

return M
