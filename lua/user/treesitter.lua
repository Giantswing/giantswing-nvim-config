local M = {
   "nvim-treesitter/nvim-treesitter",
   event = { "BufReadPost", "BufNewFile" },
   build = ":TSUpdate",
}

function M.config()
   require("nvim-treesitter.configs").setup({
      ensure_installed = {
         "bash",
         "css",
         "html",
         "javascript",
         "json",
         "lua",
         "markdown",
         "markdown_inline",
         "php",
         "python",
         "scss",
         "typescript",
         "vue",
      }, --You can put other languages in here
      highlight = {
         enable = true,
         additional_vim_regex_highlighting = true,
         custom_captures = {
            ["attr.value"] = "TSKeyword"
         }
      },
      indent = {
         enable = true,
      },
      auto_install = true,
      sync_install = true,
      ignore_install = {},
      modules = {},
      incremental_selection = {
         enable = true,
         keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
         },
      },
   })
end

return M
