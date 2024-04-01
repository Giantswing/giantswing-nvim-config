local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- this is picking the standard data path and concatenating (..)
-- the /lazy/lazy.nvim (you can see the path by doing
-- :lua print(vim.fn.stdpath("data")) (you could also write
-- "config" "state" "cache" etc

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath) --rtp stands for runtime path

--We created the LAZY_PLUGIN_SPEC in the launch.lua, now we are
--saying to lazy that we want to store the specs there
require("lazy").setup {
  spec = LAZY_PLUGIN_SPEC,
--  {import = { "user.indent" }},
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
}

