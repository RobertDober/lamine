-- local dbg = require("debugger")
-- dbg.auto_where = 2

local keys = {
  ['<Leader><Space>'] = '<Esc>',
  ['<Leader>r'] = '<C-r>',
  ['<Leader>c'] = '<C-c>',
  ['<Leader>p'] = '<C-p>',
  ['<Leader>:'] = '\\',
  ['<Leader>n'] = '~',
  ['$<Space>'] = '<Esc>:w!<Cr>',
  ['$-'] = '<Esc>:wqa<cr>',
  ['$!!'] = '<Esc>:qa!<cr>',
  ['=('] = '{',
  ['=)'] = '}',
  [':)'] = ']',
  [':('] = ']',
  ['-a'] = '<Esc>A',
}

for shortcut, mapping in pairs(keys) do
  vim.keymap.set('i', shortcut, mapping, {})
end

local function ctrl_p_completion()
  local key = vim.api.nvim_replace_termcodes('<ctrl-p>', true, false, true)
  vim.api.nvim_feedkeys(key, 'i', false)
end

-- vim.keymap.set('i', '-p', ctrl_p_completion, {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
