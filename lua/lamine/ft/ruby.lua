-- local dbg = require("debugger")
-- dbg.auto_where = 2


local function system_rdoc()
  vim.cmd('write')
  vim.system({'rdoc'}, {stdout=false})
end

vim.api.nvim_create_user_command(
  'RDoc', 
  system_rdoc, 
  {}
)
vim.keymap.set('i', '<Leader>rd', system_rdoc, {})
vim.keymap.set('n', '<Leader>rd', system_rdoc, {})

-- vim.keymap.set('i', '<Leader>-', '--', {remap = false})
-- SPDX-License-Identifier: AGPL-3.0-or-later
