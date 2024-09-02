-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function next_tab()
  vim.cmd('tabnext')
end

local function prev_tab()
  vim.cmd('tabprevious')
end
vim.keymap.set('n', '<Space>n', next_tab)
vim.keymap.set('n', '<Space>p', prev_tab)
vim.keymap.set('n', '<Space>h', '<C-W>h')
vim.keymap.set('n', '<Space>l', '<C-W>l')
vim.keymap.set('n', '<Space>k', '<C-W>k')
vim.keymap.set('n', '<Space>j', '<C-W>j')
vim.keymap.set('n', '<Space>q', ':q<cr>')
vim.keymap.set('n', '$$!!', ':q!<cr>')

-- SPDX-License-Identifier: AGPL-3.0-or-later
