-- -- This pattern returns a lazy spec,
-- -- its something that has a few properties and a string
-- -- value, if it has a string it thinks its a plugin
-- local M = {
--   --"folke/tokyonight.nvim",
--   "ayu-theme/ayu-vim",
--   -- "lunarvim/darkplus.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
-- }
--
-- -- Here we are defining a function that its going to
-- -- be hanging from this M object, it has to be called
-- -- config because lazy is expecting that to run that
-- -- particular plugin
-- function M.config()
--   --vim.cmd.colorscheme "tokyonight-night"
--   -- vim.cmd.colorscheme "darkplus"
--   vim.cmd.colorscheme "ayu"
-- end
--
-- return M

local M = {
   { "folke/tokyonight.nvim", },
   { "rose-pine/neovim", name = "rose-pine", },
   { "ayu-theme/ayu-vim", },
   { "lunarvim/darkplus.nvim", },
   { "lunarvim/colorschemes", },
   { "rafi/awesome-vim-colorschemes", },
   { "rebelot/kanagawa.nvim", },
   { "bluz71/vim-moonfly-colors", },
   { "bluz71/vim-nightfly-colors", },
   { "catppuccin/nvim", },

   -- config = function()
   --    vim.cmd.colorscheme("ayu")
   -- end,
}

return M
