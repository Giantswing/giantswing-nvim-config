local M = {
  "nvim-lualine/lualine.nvim",
    dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    -- lualine_a = {'mode'},
    lualine_a = {},
    -- lualine_a = { {'buffers', color={buf_active='#fff', buf_inactive='#333'}, buffers_color = {active = 'buf_active', inactive = 'buf_inactive'},  } },
    -- lualine_a = { 'buffers' },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    -- lualine_c = {'buffers'},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_x = {'filetype'},
    lualine_y = {'progress' },
    lualine_z = { {'location', color={ fg = '#fff' }} }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
end

return M
