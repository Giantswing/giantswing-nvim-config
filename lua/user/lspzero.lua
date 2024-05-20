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

   local lsp_zero = require('lsp-zero')

   lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({buffer = bufnr})
   end)

   require('mason').setup({})
   require('mason-lspconfig').setup({
      ensure_installed = {
         'tsserver',
         'volar',
      },
      handlers = {

         function(server_name)
            require('lspconfig')[server_name].setup({})
         end,

         tsserver = function()
            local vue_typescript_plugin = require('mason-registry')
               .get_package('vue-language-server')
               :get_install_path()
            .. '/node_modules/@vue/language-server'
            .. '/node_modules/@vue/typescript-plugin'

            require('lspconfig').tsserver.setup({
               init_options = {
                  plugins = {
                     {
                        name = "@vue/typescript-plugin",
                        location = vue_typescript_plugin,
                        languages = {'javascript', 'typescript', 'vue'}
                     },
                  }
               },
               filetypes = {
                  'javascript',
                  'javascriptreact',
                  'javascript.jsx',
                  'typescript',
                  'typescriptreact',
                  'typescript.tsx',
                  'vue',
               },
            })
         end,

         volar = function()
            require('lspconfig').volar.setup({
               filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
               init_options = {
                  vue = {
                     hybridMode = false,
                  },
               },
            })
         end,

      },
   })

end

return M
