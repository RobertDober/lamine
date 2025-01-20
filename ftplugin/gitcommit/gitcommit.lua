-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false

local function insert_commit_message(args)
  local n = args.fargs[1] or "1"
  local command = '.!git log -n 1 --format=\\%B HEAD~' .. n
  vim.cmd(command)
end

vim.api.nvim_create_user_command('InsertCommitMessage', insert_commit_message, {nargs = '?'})
-- SPDX-License-Identifier: AGPL-3.0-or-later
