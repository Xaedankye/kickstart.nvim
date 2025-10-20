return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestions = '<M-y>',
        clear_suggestions = '<C-]>',
        accept_word = '<C-j>',
      },
      color = {
        suggestion_color = '#fcae1e',
      },
    }
  end,
}
