-- local dbg = require("debugger")
-- dbg.auto_where = 2

describe('setting normal keymap for tabs and wins', function()

  describe('win navigation', function()
    local shortcuts = {
      ['<Space>h'] = '<C-W>h',
      ['<Space>l'] = '<C-W>l',
      ['<Space>k'] = '<C-W>k',
      ['<Space>j'] = '<C-W>j',
      ['<Space>q'] = ':q<cr>',
    }
    for shortcut, win_cmd in pairs(shortcuts) do
      it(shortcut .. " has the correct " .. win_cmd, function()
        assert.is.equal(vim.keymaps.n[shortcut], win_cmd)
      end)
    end
  end)

  describe('tab navigation', function()
    setup(function()
      stub(vim, "cmd")
    end)
    teardown(function()
      vim.cmd:revert()
    end)
    local shortcuts = {
      ['<Space>n'] = 'tabnext',
      ['<Space>p'] = 'tabprevious',
    }

    for shortcut, tabcmd in pairs(shortcuts) do
      it(shortcut .. ' navigates to ' .. tabcmd, function()
        vim.keymaps.n[shortcut]()
        assert.stub(vim.cmd).was.called_with(tabcmd)
      end)
    end

  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
