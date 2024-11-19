-- local dbg = require("debugger")
-- dbg.auto_where = 2

local assert_expect_keys = require'stub_nvim_keys'.assert_expect_keys
_G.assert = assert

describe('visual mode keymappings', function()
  local shortcuts = {
  ['<Leader>$'] = '<Esc>$',
  ['<Leader>r'] = '<C-r>',
  ['<Leader><Space>'] = '<Esc>',
  ['$l'] = '<<',
  ['$r'] = '>>',

  }

  for shortcut, mapping in pairs(shortcuts) do
    it(shortcut .. ' in visual mode is mapped to ' .. mapping, function()
      assert.is.equal(mapping, vim.keymaps.v[shortcut])
    end)
  end
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
