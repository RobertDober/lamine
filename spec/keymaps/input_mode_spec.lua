-- local dbg = require("debugger")
-- dbg.auto_where = 2

describe('input mode keymappings', function()
  local shortcuts = {
    ['<Leader><Space>'] = '<Esc>',
    ['<Leader>r'] = '<C-r>',
    ['<Leader>c'] = '<C-c>',
    ['<Leader>p'] = '<C-p>',
    ['<Leader>:'] = '\\',
    ['<Leader>n'] = '~',
    ['$$<Space>'] = '<Esc>:w!<Cr>',
  }

  for shortcut, mapping in pairs(shortcuts) do
    it(shortcut .. ' in input mode is mapped to ' .. mapping, function()
      assert.is.equal(vim.keymaps.i[shortcut], mapping)
    end)
  end
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later