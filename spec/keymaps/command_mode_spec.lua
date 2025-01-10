-- local dbg = require("debugger")
-- dbg.auto_where = 2

local assert_expect_keys = require'stub_nvim_keys'.assert_expect_keys
local A = require'lamine.autocompletion'
_G.assert = assert

describe('command mode keymappings', function()
  local shortcuts = {
    ['<Leader><Space>'] = '<Esc>',
  }

  for shortcut, mapping in pairs(shortcuts) do
    it(shortcut .. ' in input mode is mapped to ' .. mapping, function()
      assert.is.equal(mapping, vim.keymaps.c[shortcut])
    end)
  end
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
