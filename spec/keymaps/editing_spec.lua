-- local dbg = require("debugger")
-- dbg.auto_where = 2

local autocomplete = require'lamine.autocompletion'.autocomplete
describe('setting keymap for editing', function()

  describe('normal mode editing', function()
    local shortcuts = {
      [';='] =  "maggVG='azz",
      ['<Esc>'] =  ":set nohlsearch<CR>",
      ['='] =  "A",
      ['$l'] =  '<<',
      ['$r'] =  '>>',
      ['$-'] =  ':wqa<cr>',
      ['$<Space>'] =  ':w!<cr>',
      ['$i'] = '<C-a>',
      ['$d'] = '<C-x>',
      ['$e'] = '<C-r>',
      ['$t'] = '<C-t>',
      ['$!!'] = ':qa!<cr>', 
    }
    for shortcut, nav_cmd in pairs(shortcuts) do
      it(shortcut .. " has the correct " .. nav_cmd, function()
        assert.is.equal(nav_cmd, vim.keymaps.n[shortcut])
      end)
    end
  end)

  it('also has the command mode shortcut to exit', function()
    assert.is.equal(vim.keymaps.c['$-'], 'wqa<cr>')
    assert.is.equal(vim.keymaps.c['$!!'], 'qa!<cr>')
  end)

  it('can go to autocomplete', function()
    assert.is.equal(autocomplete, vim.keymaps.n[',,'])
  end)

end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
