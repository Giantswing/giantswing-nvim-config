local M = {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  require("colorizer").setup {
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "html",
      "astro",
      "lua",
      "vue",
      "scss",
      "php",
    },
    user_default_options = {
      names = true,
      rgb_fn = true,
      hsl_fn = true,
      --tailwind = "both",
      mode = "background" --background foreground virtualtext
    },
    buftypes = {},
  }
end

return M
