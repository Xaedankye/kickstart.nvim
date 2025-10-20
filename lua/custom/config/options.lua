if vim.env.NEOVIM_NOTES_MODE == 'true' then
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.signcolumn = 'auto'
  vim.opt.laststatus = 0
  vim.opt.statusline = ''

  print 'NEOVIM_NOTES_MODE active: Disabled line numbers.'
else
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = 'yes'
end

vim.opt.conceallevel = 2

vim.opt.showmode = false
vim.opt.mouse = 'a'

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10
