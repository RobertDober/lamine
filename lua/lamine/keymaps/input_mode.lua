-- local dbg = require("debugger")
-- dbg.auto_where = 2

local A = require'lamine.autocompletion'

local keys = {
  ['<Leader><Space>'] = '<Esc>',
  ['<Leader>='] = '<Esc>A',
  ['<Leader>$'] = '<Esc>$',
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
  [':l'] = '|',
  ['-a'] = '<Esc>A',
}

for shortcut, mapping in pairs(keys) do
  vim.keymap.set('i', shortcut, mapping, {})
end

local function ctrl_p_completion()
  local key = vim.api.nvim_replace_termcodes('<c-p>', true, false, true)
  vim.api.nvim_feedkeys(key, 'i', false)
end

vim.keymap.set('i', '-p', ctrl_p_completion, {})

vim.keymap.set('i', ',,', A.autocomplete, {})
vim.keymap.set('i', ',;', A.autocontinue, {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
