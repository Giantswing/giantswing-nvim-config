local M = {
  "ibhagwan/fzf-lua",
  dependencies = { "junegunn/fzf" },
options = {
      files = {
      find_opts = "-type f"
    }
  },

  setup = function()
    vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
    vim.g.fzf_action = {
      ["ctrl-t"] = "tab split",
      ["ctrl-x"] = "split",
      ["ctrl-v"] = "vsplit",
    },
  end,
}

return M
