-- vim.o.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
require("user.launch") --Prepares a table of specs (so we can install things later more easily)
require("user.options")
require("user.keymaps")
require("user.autocmds")

spec("user.comment")
spec("user.colorscheme")
spec("user.whichkey")
spec("user.treesitter") --Installs highlighting and indenting for languages
spec("user.autopairs")
spec("user.copilot")
spec("user.oil")
spec("user.telescope")
spec("user.plenary")
spec("user.lspzero")
spec("user.sort")
spec("user.lualine")
spec("user.illuminate")
spec("user.colorizer")
spec("user.mini")
spec("user.harpoon")
spec("user.visualmulti")
spec("user.easymotion")
spec("user.indent")
spec("user.yanky")
spec("user.closetag")
spec("user.tree")
spec("user.context")
spec("user.sleuth") --this is for detecting the indentation of a file and adjusting
spec("user.marks")
spec("user.gitsigns")

-- spec("user.narrow")
-- spec("user.none-ls")
-- spec("user.ufo")
-- spec("user.maximizer")
-- spec("user.tailwindsorter")
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

spec("user.transparent")
vim.g.transparent_enabled = true
-- vim.cmd("set guicursor=")

require("user.lazy")
--
-- vim.cmd("VMDebug")
vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme kanagawa-dragon")



vim.cmd("hi Normal guibg=NONE")
vim.cmd("hi NonText guibg=NONE")
vim.cmd("hi SignColumn guibg=NONE")
vim.cmd("hi EndOfBuffer guibg=NONE")

