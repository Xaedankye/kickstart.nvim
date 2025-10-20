-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/render-markdown.lua

local colors = require 'custom.config.colors'

return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = false,
  init = function()
    local colorInline_bg = colors['linkarzu_color02']
    local color_fg = colors['linkarzu_color26']
    if vim.g.md_heading_bg == 'transparent' then
      local color1_bg = colors['linkarzu_color04']
      local color2_bg = colors['linkarzu_color02']
      local color3_bg = colors['linkarzu_color03']
      local color4_bg = colors['linkarzu_color01']
      local color5_bg = colors['linkarzu_color05']
      local color6_bg = colors['linkarzu_color08']
      local color_fg1 = colors['linkarzu_color18']
      local color_fg2 = colors['linkarzu_color19']
      local color_fg3 = colors['linkarzu_color20']
      local color_fg4 = colors['linkarzu_color21']
      local color_fg5 = colors['linkarzu_color22']
      local color_fg6 = colors['linkarzu_color23']

      vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s ]], color_fg1, color1_bg))
      vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s ]], color_fg2, color2_bg))
      vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s ]], color_fg3, color3_bg))
      vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s ]], color_fg4, color4_bg))
      vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s ]], color_fg5, color5_bg))
      vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s ]], color_fg6, color6_bg))
      vim.cmd(string.format([[highlight RenderMarkdownCodeInline guifg=%s guibg=%s]], colorInline_bg, color_fg))
      vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
      vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
      vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
      vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
      vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
      vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
    else
      local color1_bg = colors['linkarzu_color18']
      local color2_bg = colors['linkarzu_color19']
      local color3_bg = colors['linkarzu_color20']
      local color4_bg = colors['linkarzu_color21']
      local color5_bg = colors['linkarzu_color22']
      local color6_bg = colors['linkarzu_color23']
      vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
      vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
      vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
      vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
      vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
      vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))
    end
  end,
  -- All configuration must go inside the 'opts' table
  opts = {
    -- The 'checkbox' section is valid
    checkbox = {
      enabled = true,
      position = 'inline',
      unchecked = {
        icon = '  󰄱 ',
        highlight = 'RenderMarkdownUnchecked',
        scope_highlight = nil,
      },
      checked = {
        icon = '   ',
        highlight = 'RenderMarkdownChecked',
        scope_highlight = nil,
      },
      custom = {
        important = {
          rendered = ' ',
          highlight = 'RenderMarkdownImportant',
        },
        right_arrow = {
          rendered = ' ',
          highlight = 'RenderMarkdownRightArrow',
        },
      },
    },

    -- MOVED from outside into 'opts'
    html = {
      enabled = true,
      comment = {
        conceal = false,
      },
    },

    -- MOVED from outside into 'opts'
    link = {
      image = vim.g.neovim_mode == 'skitty' and '' or '󰥶 ',
      custom = {
        youtu = { pattern = 'youtu%.be', icon = '󰗃 ' },
      },
    },

    -- MOVED from outside into 'opts'
    heading = {
      sign = false,
      icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
      backgrounds = {
        'Headline1Bg',
        'Headline2Bg',
        'Headline3Bg',
        'Headline4Bg',
        'Headline5Bg',
        'Headline6Bg',
      },
      foregrounds = {
        'Headline1Fg',
        'Headline2Fg',
        'Headline3Fg',
        'Headline4Fg',
        'Headline5Fg',
        'Headline6Fg',
      },
    },

    -- MOVED from outside into 'opts'
    code = {
      style = 'none',
    },
  },
}
