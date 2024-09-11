-- local dbg = require("debugger")
-- dbg.auto_where = 2


describe('setting keymap for editing', function()

  describe('normal mode editing', function()
    local shortcuts = {
      [';='] =  "maggVG='azz",
      ['<Esc>'] =  ":set nohlsearch<CR>",
      ['='] =  "A",
      ['$$l'] =  '<<',
      ['$$r'] =  '>>',
      ['$$-'] =  ':wqa<cr>',
      ['$$<Space>'] =  ':w!<cr>',
      ['$$i'] = '<C-a>',
      ['$$d'] = '<C-x>',
      ['$$e'] = '<C-r>',
      ['$$t'] = '<C-t>',
    }
    for shortcut, nav_cmd in pairs(shortcuts) do
      it(shortcut .. " has the correct " .. nav_cmd, function()
        assert.is.equal(vim.keymaps.n[shortcut], nav_cmd)
      end)
    end
  end)

  describe('exiting from input mode', function()
    local shortcuts = {
      ['$$-'] =  '<Esc>:wqa<cr>',
      ['$$!!'] =  '<Esc>:qa!<cr>',
    }
    
    for shortcut, exit_cmd in pairs(shortcuts) do
      it(shortcut .. " has the correct " .. exit_cmd, function()
        assert.is.equal(vim.keymaps.i[shortcut], exit_cmd)
      end)
    end
  end)

  it('also has the command mode shortcut to exit', function()
        assert.is.equal(vim.keymaps.c['$$-'], 'wqa<cr>')
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
