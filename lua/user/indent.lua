local M = {
   "lukas-reineke/indent-blankline.nvim",
   event = "VeryLazy",
   commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
}

function M.config()
   local icons = require "user.icons"

   require("indent_blankline").setup {
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
         "help",
         "startify",
         "dashboard",
         "lazy",
         "neogitstatus",
         "NvimTree",
         "Trouble",
         "text",
      },
      show_trailing_blankline_indent = true,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = true,
   }
end

return M



-- local M = {
--    "lukas-reineke/indent-blankline.nvim",
--    main = "ibl",
--    event = "VeryLazy",
--    commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
--    opts = function(_, opts)
--       -- Other blankline configuration here
--       return require("indent-rainbowline").make_opts(opts)
--    end,
--    dependencies = {
--       "TheGLander/indent-rainbowline.nvim",
--    },
-- }


-- function M.config()
--    local highlight = {
--       "Color1",
--       -- "Color2",
--       -- "Color3",
--       -- "Color4",
--       "Color5",
--       "Color6",
--    }
--    local hooks = require("ibl.hooks")
--    -- create the highlight groups in the highlight setup hook, so they are reset
--    -- every time the colorscheme changes
--    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--    vim.api.nvim_set_hl(0, "Color1", { fg = "#1a3d5b" }) -- Darker and desaturated
--       -- vim.api.nvim_set_hl(0, "Color2", { fg = "#45271d" }) -- Darker and more desaturated
--       -- vim.api.nvim_set_hl(0, "Color3", { fg = "#484832" }) -- Darker and more desaturated
--       -- vim.api.nvim_set_hl(0, "Color4", { fg = "#12263f" }) -- Darker and more desaturated
--       vim.api.nvim_set_hl(0, "Color5", { fg = "#133b38" }) -- Darker and more desaturated
--       vim.api.nvim_set_hl(0, "Color6", { fg = "#36453b" }) -- Darker and more desaturated
--    end)
--
--    require("ibl").setup({ indent = { highlight = highlight } })
--    -- vim.g.rainbow_delimiters = { highlight = highlight }
--    -- require("ibl").setup({ scope = {
--    --
--    --   enabled = true,
--    --   highlight = highlight } })
--    --
--    -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
-- end
--
-- return M

