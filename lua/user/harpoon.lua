-- local M = {
--    "theprimeagen/harpoon",
--    branch = "harpoon2",
--    dependencies = { "nvim-lua/plenary.nvim" },
--    config = function()
--       require("harpoon"):setup()
--    end,
--    keys = {
--       { "<leader>A", function() require("user.harpoon"):list():append() end, desc = "harpoon file", },
--       { "<TAB>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
--       { "<leader>1", function() require("user.harpoon"):list():select(1) end, desc = "harpoon to file 1", },
--       { "<leader>2", function() require("user.harpoon"):list():select(2) end, desc = "harpoon to file 2", },
--       { "<leader>3", function() require("user.harpoon"):list():select(3) end, desc = "harpoon to file 3", },
--       { "<leader>4", function() require("user.harpoon"):list():select(4) end, desc = "harpoon to file 4", },
--       { "<leader>5", function() require("user.harpoon"):list():select(5) end, desc = "harpoon to file 5", },
--    }
-- }
--
-- return M

local toggle_opts = {
   border = "rounded",
   title_pos = "left",
   ui_width_ratio = 0.45,
}

local keys = {
   { "<leader>a", function() require("harpoon"):list():append() end, desc = "harpoon file", },
   { "<TAB>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list(),toggle_opts) end, desc = "harpoon quick menu", },
   { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
   { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
   { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
   { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
   { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
}

local M = {
	"ThePrimeagen/harpoon",
   branch = "harpoon2",
	-- event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
   keys = keys,
}

-- function M.config()
-- 	local keymap = vim.keymap.set
-- 	local opts = { noremap = true, silent = true }
--    local harpoon = require("harpoon")
--
-- 	keymap("n", "<s-m>", "<cmd>lua require('user.harpoon').mark_file()<cr>", opts)
-- 	keymap("n", "<TAB>", "<cmd>lua require('user.harpoon').toggle_menu()<cr>", opts)
--    vim.keymap.set("n", "<TAB>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)
--    vim.keymap.set("n", "<leader>h", function() require("harpoon.ui").toggle_quick_menu(harpoon:list(), toggle_opts) end)
-- end
--
-- function M.mark_file()
-- 	require("harpoon.mark").add_file()
-- 	vim.notify("󱡅  marked file")
-- end
--
-- function M.toggle_menu()
-- 	local toggle_opts = {
-- 		border = "rounded",
-- 		title_pos = "center",
-- 		ui_width_ratio = 0.80,
-- 	}
--    -- local list = require("harpoon.list")
--    require("harpoon.cmd-ui").toggle_quick_menu(toggle_opts)
-- end


return M
