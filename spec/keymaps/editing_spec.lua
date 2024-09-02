-- local dbg = require("debugger")
-- dbg.auto_where = 2


describe('setting keymap for editing', function()

  describe('win navigation', function()
    local shortcuts = {
      ['<Leader>='] =  "maggVG='azz",
      ['<Esc>'] =  ":set nohlsearch<CR>",
      ['='] =  "A",
      ['$$l'] =  '<<',
      ['$$r'] =  '>>',
      ['$$-'] =  ':wqa<cr>',
    }
    for shortcut, nav_cmd in pairs(shortcuts) do
      it(shortcut .. " has the correct " .. nav_cmd, function()
        assert.is.equal(vim.keymaps.n[shortcut], nav_cmd)
      end)
    end
  end)

  it('also has the command mode shortcut to exit', function()
        assert.is.equal(vim.keymaps.c['$$-'], 'wqa<cr>')
  end)
  it('also has the input mode shortcut to exit', function()
        assert.is.equal(vim.keymaps.i['$$-'], '<Esc>:wqa<cr>')
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
