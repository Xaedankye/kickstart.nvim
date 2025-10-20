return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim', -- Optional, for the picker
    'hrsh7th/nvim-cmp', -- Optional, for completion
    'nvim-treesitter/nvim-treesitter', -- Optional, for syntax highlighting
  },
  opts = {

    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
      {
        name = 'work',
        path = '~/vaults/work',
      },
    },

    -- see below for full list of options 👇
    notes_subdir = 'notes',

    log_level = vim.log.levels.INFO,

    daily_notes = {
      folder = 'notes/dailies',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'daily-notes' },
      template = 'daily_template.md',
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    mappings = {},

    new_notes_location = 'notes_subdir',

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,

    prefered_link_style = 'markdown',

    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = '<C-x>',
        -- Insert a tag at the current location.
        insert_tag = '<C-l>',
      },
    },

    sort_by = 'modified',
    sort_reversed = true,

    search_max_lines = 1000,

    open_notes_in = 'current',

    ui = {
      enable = true, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        -- Replace the above with this if you don't have a patched font:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- You can also add more custom ones...
      },
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
      external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = 'ObsidianRefText' },
      highlight_text = { hl_group = 'ObsidianHighlightText' },
      tags = { hl_group = 'ObsidianTag' },
      block_ids = { hl_group = 'ObsidianBlockID' },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = '#f78c6c' },
        ObsidianDone = { bold = true, fg = '#89ddff' },
        ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianImportant = { bold = true, fg = '#d73128' },
        ObsidianBullet = { bold = true, fg = '#89ddff' },
        ObsidianRefText = { underline = true, fg = '#c792ea' },
        ObsidianExtLinkIcon = { fg = '#c792ea' },
        ObsidianTag = { italic = true, fg = '#89ddff' },
        ObsidianBlockID = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
      },
    },
  },

  keys = {
    { '<leader>zo', '<cmd>ObsidianToday<cr>', desc = "Open today's note" },
    { '<leader>zn', '<cmd>ObsidianNew<cr>', desc = 'Create a new note' },
    { '<leader>zl', '<cmd>ObsidianLinkNewNote<cr>', desc = 'Create a new linked note' },
    { '<leader>zL', '<cmd>ObsidianLinkExistingNote<cr>', desc = 'Link to an existing note' },
    { '<leader>zt', '<cmd>ObsidianTags<cr>', desc = 'Open tags picker' },
    { '<leader>zT', '<cmd>ObsidianTemplates<cr>', desc = 'Open templates picker' },
    { '<leader>zP', '<cmd>ObsidianPicker<cr>', desc = 'Open notes picker' },
    { '<leader>zD', '<cmd>ObsidianDailyNotes<cr>', desc = 'Open daily notes picker' },
    { '<leader>zR', '<cmd>ObsidianRenameNote<cr>', desc = 'Rename current note' },
    { '<leader>zI', '<cmd>ObsidianInsertLink<cr>', desc = 'Insert link to current note' },
    { '<leader>zC', '<cmd>ObsidianCopyLink<cr>', desc = 'Copy link to current note' },
    { '<leader>zS', '<cmd>ObsidianSearch<cr>', desc = 'Search in notes' },
    { '<leader>zF', '<cmd>ObsidianFollowLink<cr>', desc = 'Follow link under cursor' },
    { '<leader>zA', '<cmd>ObsidianAddTag<cr>', desc = 'Add tag to current note' },
    { '<leader>zE', '<cmd>ObsidianEditTemplates<cr>', desc = 'Edit templates' },
    { '<leader>zM', '<cmd>ObsidianManageWorkspaces<cr>', desc = 'Manage workspaces' },
    { '<leader>zw', '<cmd>ObsidianWorkspace<cr>', desc = 'Switch workspace' },
    { '<leader>zW', '<cmd>ObsidianWorkspaceNew<cr>', desc = 'Create new workspace' },
    { '<leader>zX', '<cmd>ObsidianWorkspaceDelete<cr>', desc = 'Delete current workspace' },
  },
}
