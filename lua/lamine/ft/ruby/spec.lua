-- local dbg = require("debugger")
-- dbg.auto_where = 2

local map_lines = require'lamine.filter'.map_lines

local function make_expect_equal_line(prefix, actual, expected)
  return prefix .. 'expect(' .. actual .. ').to eq(' .. expected .. ')'
end

local function make_expect_line(line)
  local prefix, actual, expected = string.match(line, "^(%s*)(%S+)(%s+)(%S+)%s*$")
  if expected then
    return make_expect_equal_line(prefix, actual, expected)
  end

  prefix, actual = string.match(line, "^(%s*)(.*)")
  return prefix .. 'expect(' .. string.gsub(actual, '%s*$', '') .. ').to '
end

local function make_expect(args)
  return map_lines(args.line1, args.line2, make_expect_line, true)
end

local function make_xpct_line(line)
  local prefix, actual = string.match(line, "^(%s*)(.*)")
  return prefix .. 'expect { ' .. string.gsub(actual, '%s*$', '') .. '}.to ' 
end

local function make_xpct(args)
  return map_lines(args.line1, args.line2, make_xpct_line, true)
end

vim.api.nvim_create_user_command(
  'Expect', 
  make_expect,
  {range = true}
)
vim.api.nvim_create_user_command(
  'Xpct', 
  make_xpct,
  {range = true}
)
vim.keymap.set('i', '<Leader>xp', 'Expect<CR>', {})
vim.keymap.set('n', '<Leader>xp', 'Expect<CR>', {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
