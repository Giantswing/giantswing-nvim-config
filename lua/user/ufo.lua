local M = {
   "kevinhwang91/nvim-ufo",
   dependencies = "kevinhwang91/promise-async",
   event = "VeryLazy",
}

function M.config()
   vim.o.foldcolumn = '0' -- '0' is not bad
   vim.o.foldlevel = 40 --  99 Using ufo provider need a large value, feel free to decrease the value
   vim.o.foldlevelstart = 40
   vim.o.foldenable = true

   vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
   vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
   vim.keymap.set('n', 'zj', require('ufo').goNextClosedFold)
   vim.keymap.set('n', 'zk', require('ufo').goPreviousClosedFold)

   -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
   -- require('ufo').setup()


   -- require('ufo').setup({
   --    provider_selector = function(bufnr, filetype, buftype)
   --       return ''
   --    end
   -- })


   require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
         return {'indent'}
      end
   })
end

return M

-- local M = {
--    "kevinhwang91/nvim-ufo",
--    dependencies = "kevinhwang91/promise-async",
--    event = "VimEnter", -- needed for folds to load in time and comments closed
--    keys = {
--       { "zm", function() require("ufo").closeAllFolds() end, desc = " 󱃄 Close All Folds" },
--       { "zk", function() require("ufo").goPreviousClosedFold() end, desc = " 󱃄 Goto Prev Fold" },
--       { "zj", function() require("ufo").goNextClosedFold() end, desc = " 󱃄 Goto Next Fold" },
--       { "zr", function() require("ufo").openFoldsExceptKinds { "comment", "imports" } end, desc = " 󱃄 Open All Regular Folds" },
--       { "zR", function() require("ufo").openFoldsExceptKinds {} end, desc = " 󱃄 Open All Folds" },
--       { "z1", function() require("ufo").closeFoldsWith(1) end, desc = " 󱃄 Close L1 Folds" },
--       { "z2", function() require("ufo").closeFoldsWith(2) end, desc = " 󱃄 Close L2 Folds" },
--       { "z3", function() require("ufo").closeFoldsWith(3) end, desc = " 󱃄 Close L3 Folds" },
--       { "z4", function() require("ufo").closeFoldsWith(4) end, desc = " 󱃄 Close L4 Folds" },
--    },
--    init = function()
--       vim.opt.foldlevel = 99
--       vim.opt.foldlevelstart = 99
--    end,
--    opts = {
--       provider_selector = function(_, ft, _)
--          local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
--          if vim.tbl_contains(lspWithOutFolding, ft) then
--             return { "treesitter", "indent" }
--          end
--          return { "lsp", "indent" }
--       end,
--       close_fold_kinds = { "imports", "comment" },
--       open_fold_hl_timeout = 800,
--    },
-- }
--
-- function M.config() end
--
-- return M
