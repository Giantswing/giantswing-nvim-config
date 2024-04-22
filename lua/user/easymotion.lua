local M = {
   -- 'easymotion/vim-easymotion',
   'rlane/pounce.nvim',
    opts = {},
   event = "VeryLazy",
}

function M.config()
   require("pounce").setup{
     accept_keys = "asdfghjklqwertyuiopzxcvbnm",
   }

end

return M
