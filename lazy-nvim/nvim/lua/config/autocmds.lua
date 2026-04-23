-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

local function is_ts_like(ft)
  return ft == "typescript"
    or ft == "typescriptreact"
    or ft == "javascript"
    or ft == "javascriptreact"
end

local function find_up(name, start_dir)
  local found = vim.fs.find(name, { path = start_dir, upward = true })
  return found and found[1] or nil
end

local function configure_ts_pnpm_make(bufnr)
  local ft = vim.bo[bufnr].filetype
  if not is_ts_like(ft) then
    return
  end

  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    return
  end

  local start_dir = vim.fs.dirname(fname)

  -- TS project heuristic
  local tsconfig = find_up("tsconfig.json", start_dir)
  local pkg = find_up("package.json", start_dir)
  if not tsconfig or not pkg then
    return
  end

  -- Use nearest package.json directory as root (works well in monorepos)
  local root = vim.fs.dirname(pkg)

  -- pnpm heuristic
  local pnpm_lock = find_up("pnpm-lock.yaml", root)
  local pnpm_ws = find_up("pnpm-workspace.yaml", root)
  if not pnpm_lock and not pnpm_ws then
    return
  end

  -- Avoid reapplying every time
  if vim.b[bufnr].ts_pnpm_make_root == root then
    return
  end
  vim.b[bufnr].ts_pnpm_make_root = root

  -- Run build from root without changing Neovim's cwd
  -- -s reduces pnpm noise; remove if you want full logs.
  vim.bo[bufnr].makeprg = ("cd %s && pnpm run build"):format(vim.fn.shellescape(root))

  -- errorformat: list of patterns (CSV) used to parse output lines into quickfix entries [2](https://vim.fandom.com/wiki/Errorformats)[3](https://flukus.github.io/vim-errorformat-demystified.html)
  -- Includes patterns commonly seen in webpack + ts-loader output like:
  --   ERROR in /abs/path/src/index.ts ./src/index.ts 3:23-26 [tsl] ERROR in /abs/path/src/index.ts(3,24) TS2304: msg [4](https://www.reddit.com/r/vim/comments/18d489r/webpack_errorformat/)
  vim.bo[bufnr].errorformat = table.concat({
    -- tsc / fork-ts-checker / “file.ts(12,34): error TS2322: msg”
    "%E%f(%l,%c): error TS%n: %m",
    "%W%f(%l,%c): warning TS%n: %m",
    -- alternate tsc-ish formats
    "%E%f:%l:%c - error TS%n: %m",
    "%W%f:%l:%c - warning TS%n: %m",
    "%E%f:%l:%c: error TS%n: %m",
    "%W%f:%l:%c: warning TS%n: %m",

    -- ts-loader line often contains: “[tsl] ERROR in file.ts(3,24) TS2304: msg” [4](https://www.reddit.com/r/vim/comments/18d489r/webpack_errorformat/)
    "%E%.%#[tsl] ERROR in %f(%l,%c) TS%n: %m",
    "%W%.%#[tsl] WARNING in %f(%l,%c) TS%n: %m",

    -- webpack “ERROR in <abs> <rel> 3:23-26 ...” (capture the *second* path)
    "%EERROR in %*[^ ] %f %l:%c%*[^ ] %m",
    -- webpack “ERROR in ./src/index.ts 3:23-26 ...”
    "%EERROR in %f %l:%c%*[^ ] %m",

    -- Some loaders print “SyntaxError (2:7) ...”
    "%ESyntaxError (%l:%c) %m",

    -- continuation lines (webpack tends to wrap/indent)
    "%C %m",
    "%C%m",

    -- ignore common noise
    "%-Gwebpack compiled%.%#",
    "%-GHash:%.%#",
    "%-GVersion:%.%#",
    "%-GTime:%.%#",
    "%-G%.%#",
  }, ",")
end

-- Configure per-buffer on entry/change
local group = vim.api.nvim_create_augroup("ts_pnpm_make", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "DirChanged", "FileType" }, {
  group = group,
  callback = function(args)
    configure_ts_pnpm_make(args.buf)
  end,
})

-- Optional: auto-open quickfix after :make if there are entries
local qf_group = vim.api.nvim_create_augroup("ts_pnpm_make_qf", { clear = true })
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = qf_group,
  pattern = "make",
  callback = function()
    if #vim.fn.getqflist() > 0 then
      vim.cmd("cwindow")
    end
  end,
})
