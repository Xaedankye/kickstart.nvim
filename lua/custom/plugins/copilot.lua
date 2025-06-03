vim.keymap.set('i', '<M-j>', '<Plug>(copilot-dismiss)')

vim.keymap.set('i', '<M-y>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

return {}
