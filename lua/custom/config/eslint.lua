-- ~/.config/nvim/lua/custom/config/eslint.lua
-- Project-first ESLint resolution with safe fallback (no repo edits required)

local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local uv = vim.uv or vim.loop

-- --- helpers ---------------------------------------------------------------

local function sep()
  return util.path.sep
end
local function join(...)
  return table.concat({ ... }, sep())
end
local function dirname(p)
  return p:match('(.*)' .. sep() .. '[^' .. sep() .. ']+$')
end
local function exists(p)
  return p and uv.fs_stat(p) ~= nil
end

local function has_any_eslint_config(root)
  local names = {
    'eslint.config.js',
    'eslint.config.cjs',
    'eslint.config.mjs',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
    '.eslintrc.yml',
  }
  for _, n in ipairs(names) do
    if exists(join(root, n)) then
      return true
    end
  end
  return false
end

local function has_flat_config(root)
  return exists(join(root, 'eslint.config.js')) or exists(join(root, 'eslint.config.cjs')) or exists(join(root, 'eslint.config.mjs'))
end

-- Walk up from start -> filesystem root to find a node_modules that contains
-- the given module (e.g. "eslint/package.json" or "@typescript-eslint/eslint-plugin/package.json")
local function find_node_modules_with(start, module_rel_pkgjson)
  local dir = start
  while dir and dir ~= '' do
    local nm = join(dir, 'node_modules')
    if exists(nm) and exists(join(nm, module_rel_pkgjson)) then
      return nm
    end
    local parent = dirname(dir)
    if not parent or parent == dir then
      break
    end
    dir = parent
  end
  return nil
end

-- pick the best node_modules for plugin resolution
local function resolve_node_modules(root)
  -- prefer where the plugin is installed, fallback to where eslint is installed,
  -- finally fallback to the package's own node_modules (even if empty)
  return find_node_modules_with(root, '@typescript-eslint/eslint-plugin/package.json')
    or find_node_modules_with(root, 'eslint/package.json')
    or (exists(join(root, 'node_modules')) and join(root, 'node_modules'))
    or nil
end

-- --- lsp setup -------------------------------------------------------------

local root_markers = {
  'eslint.config.js',
  'eslint.config.cjs',
  'eslint.config.mjs',
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.json',
  '.eslintrc.yml',
  'package.json',
  'pnpm-workspace.yaml',
  'turbo.json',
  'nx.json',
  '.git',
}

lspconfig.eslint.setup {
  -- nearest package/repo root
  root_dir = util.root_pattern(unpack(root_markers)),

  settings = {
    -- make the server pick the right cwd per subpackage
    workingDirectories = { mode = 'auto' },
    codeAction = { disableRuleComment = { enable = true, location = 'separateLine' } },
    format = true,
    run = 'onType',
    -- packageManager = "pnpm", -- uncomment if you use pnpm/yarn/npm explicitly
  },

  on_new_config = function(new_config, root)
    new_config.settings = new_config.settings or {}
    new_config.settings.options = new_config.settings.options or {}

    -- 1) point ESLint to the correct node_modules
    local nm = resolve_node_modules(root)
    if nm then
      -- let the server locate eslint & plugins from here
      new_config.settings.nodePath = nm
      new_config.settings.options.resolvePluginsRelativeTo = nm
      -- also give Node a hint (helps in some quirky mono/pnp setups)
      new_config.cmd_env = vim.tbl_deep_extend('force', new_config.cmd_env or {}, { NODE_PATH = nm })
    end

    -- 2) auto-enable flat config mode when a flat config is present
    if has_flat_config(root) then
      new_config.settings.experimental = new_config.settings.experimental or {}
      new_config.settings.experimental.useFlatConfig = true
    end

    -- 3) OPTIONAL: user fallback config when a package has no ESLint config.
    --    This does not modify the repo; it only affects editor diagnostics.
    --    Choose ONE of these and create the file if you want this behavior.
    -- local fallback_flat = vim.fn.expand("~/.config/nvim/lua/custom/config/eslint.config.cjs")  -- ESLint 9 flat
    -- local fallback_rc   = vim.fn.expand("~/.config/nvim/lua/custom/config/.eslintrc.cjs")      -- ESLint 8 classic
    -- if not has_any_eslint_config(root) and exists(fallback_flat) then
    --   new_config.settings.options.overrideConfigFile = fallback_flat
    -- elseif not has_any_eslint_config(root) and exists(fallback_rc) then
    --   new_config.settings.options.overrideConfigFile = fallback_rc
    -- end
  end,
}
