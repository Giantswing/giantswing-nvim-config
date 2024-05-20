local M = {
  "williamboman/mason.nvim",
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'l3mon4d3/luasnip',
  },
}

function M.config()
  require("mason").setup({})
  require("mason-lspconfig").setup({})

  require("mason-lspconfig").setup_handlers {
    --Default handler
    function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {}
    end,

    --Custom handlers
    -- ["rust_analyzer"] = function ()
    --   require("rust-tools").setup {}
    -- end
  }

end

return M
