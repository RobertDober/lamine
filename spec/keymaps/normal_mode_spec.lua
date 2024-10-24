-- local dbg = require("debugger")
-- dbg.auto_where = 2

local assert_executed_cmds = require'stub_nvim_cmds'.assert_executed_cmds

_G.assert = assert

describe('normal mode functional keymappings', function()
  local shortcuts = {
    ['<Space>n'] = 'tabnext',
    ['<Space>p'] = 'tabprevious',
  }

  for shortcut, command in pairs(shortcuts) do
    it(shortcut .. ' in input mode is mapped to cmd ' .. command, function()
      assert_executed_cmds{mode='n', keys=shortcut, command=command}
    end)
  end
end)

describe('normal mode textual keymappings', function()
  local shortcuts = {
    ['<Space>h'] = '<C-W>h',
    ['<Space>l'] = '<C-W>l',
    ['<Space>k'] = '<C-W>k',
    ['<Space>j'] = '<C-W>j',
    ['<Space>q'] = ':q<cr>',
    ['$$!!'] = ':q!<cr>',
  }
  for shortcut, mapping in pairs(shortcuts) do
    it(shortcut .. ' in input mode is mapped to ' .. mapping, function()
      assert.is.equal(mapping, vim.keymaps.n[shortcut])
    end)
  end
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
