-- local dbg = require("debugger")
-- dbg.auto_where = 2

local A = require'lamine.autocompletion'

local keys = {
  ['<Tab><Space>'] = '<Esc>',
  ['<Tab>='] = '<Esc>A',
  ['<Tab>$'] = '<Esc>$',
  ['<Tab>r'] = '<C-r>',
  ['<Tab>c'] = '<C-c>',
  ['<Tab>p'] = '<C-p>',
  ['<Tab>:'] = '\\',
  ['<Tab>n'] = '~',
  ['$<Space>'] = '<Esc>:w!<Cr>',
  ['$-'] = '<Esc>:wqa<cr>',
  ['$!!'] = '<Esc>:qa!<cr>',
  -- ['=('] = '{',
  -- ['=)'] = '}',
  -- [':)'] = ']',
  -- [':('] = ']',
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

local function insert_empty_line(move_to_insert)
  return function()
    local ctx = require'lamine.context'
    local api = require'lamine.api'
    api.set_lines_after("")
    api.set_cursor(ctx.relative_offset{1, 999})
    if move_to_insert then
      vim.api.nvim_feedkeys('a', 'i', false)
    end
  end
end

vim.keymap.set('i', '-p', ctrl_p_completion, {})
vim.keymap.set('i', '<Tab>o', insert_empty_line(), {})
vim.keymap.set('n', '<Tab>o', insert_empty_line(true), {})

vim.keymap.set('i', ',,', A.autocomplete, {})
vim.keymap.set('i', ',;', A.autocontinue, {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
