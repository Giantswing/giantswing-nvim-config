local M = {
  "declancm/cinnamon.nvim",

}

function M.config()
  require('cinnamon').setup {
  extra_keymaps = true,
  override_keymaps = true,
  max_length = 500,
  scroll_limit = -1,
  default_delay = 2,
}
end

return M
