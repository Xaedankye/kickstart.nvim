return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  dependencies = { 'nvim-telescope/telescope.nvim' },
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
  config = function()
    require('telescope').load_extension 'lazygit'
  end,
}
