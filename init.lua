-- vim.o.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
require("user.launch") --Prepares a table of specs (so we can install things later more easily)
require("user.options")
require("user.keymaps")
require("user.autocmds")

spec("user.colorscheme")
spec("user.treesitter") --Installs highlighting and indenting for languages
spec("user.autopairs")
spec("user.copilot")
spec("user.oil")
spec("user.telescope")
spec("user.plenary")
spec("user.whichkey")
spec("user.ufo")
spec("user.lspzero")
spec("user.sort")
spec("user.lualine")
spec("user.none-ls")
spec("user.comment")
spec("user.illuminate")
spec("user.colorizer")
spec("user.mini")
spec("user.harpoon")
spec("user.visualmulti")
spec("user.easymotion")
spec("user.indent")
spec("user.yanky")
spec("user.closetag")
spec("user.narrow")
spec("user.tree")
-- spec("user.maximizer")

spec("user.context")
spec("user.tailwindsorter")
spec("user.sleuth") --this is for detecting the indentation of a file and adjusting
spec("user.breadcrumbs")

-- spec("user.tabbar")

-- spec("user.playground")
-- spec("user.tailwindcsscolors")
-- spec("user.modificator")
-- spec("user.hop")
-- spec("user.neotab")
-- spec("user.rainbow") --this sucks, it's not worth it, too slow
-- spec("user.surfer")
-- spec("user.devicons")
--spec('user.mason') --Installs the language servers
-- spec("user.schemastore")
--spec('user.lspconfig')
-- spec("user.leap")

require("user.lazy")
--
-- vim.cmd("VMDebug")
vim.cmd("colorscheme onedark")

