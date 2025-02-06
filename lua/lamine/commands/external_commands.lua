-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function draw(args)
  -- vim.print(args)
  vim.cmd(args.line1 .. ',' .. args.line2 .. '!draw ' .. args.args)
end

vim.api.nvim_create_user_command('Draw', draw, {nargs='*', range=true})

vim.keymap.set('n', '<Tab>d', ':Draw', {})
vim.keymap.set('i', '<Tab>d', '<Esc>:Draw', {})
vim.keymap.set('v', '<Tab>d', ':Draw', {})

-- SPDX-License-Identifier: AGPL-3.0-or-later
