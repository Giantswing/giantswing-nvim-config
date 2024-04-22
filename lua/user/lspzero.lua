local M = {
   'vonheikemen/lsp-zero.nvim',
   branch = 'v3.x',
   event = { "BufReadPre", "BufNewFile" },
   dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'l3mon4d3/luasnip',
   },
   -- Event = 'VeryLazy',
}



function M.config()
   local lsp_zero = require "lsp-zero"

   require('mason').setup({})
   require('mason-lspconfig').setup({
      handlers = {
         lsp_zero.default_setup,
         lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
         end,
         intelephense = function()
            require('lspconfig').intelephense.setup({})
         end,
         volar = function()
            require('lspconfig').volar.setup({})
         end,
      },
   })

   lsp_zero.on_attach(function(client, bufnr)
     lsp_zero.default_keymaps({buffer = bufnr})
   end)
   -- require('luasnip').setup({
   --   config = {
   --     history = true,
   --     updateevents = 'TextChanged,TextChangedI',
   --   },
   -- })
end

return M
