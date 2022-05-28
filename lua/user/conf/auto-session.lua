local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
    vim.notify("auto-session not found!", "error")
    return
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

local opts = {
  log_level = 'info',
  auto_session_enable_last_session = nil,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = nil,

  -- the feature will invaild when nvimtree is open, so we close the nvimtree first
  pre_save_cmds = { "tabdo NvimTreeClose" },
}

print("session cache:" .. opts.auto_session_root_dir)
require('auto-session').setup(opts)
