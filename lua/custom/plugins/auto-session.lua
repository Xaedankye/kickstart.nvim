return {
  'rmagatti/auto-session',
  keys = {
    { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session Search' },
    { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Session Save' },
    { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle Autosave' },
  },
  config = function()
    require('auto-session').setup {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    }
  end,
}
