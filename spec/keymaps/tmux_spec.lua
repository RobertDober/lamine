-- local dbg = require("debugger")
-- dbg.auto_where = 2

describe("setting all keymaps for tmux", function()
  setup(function()
    vim.commands = {}
    stub(os, "execute")
  end)
  teardown(function()
    os.execute:revert()
  end)

  local shortcuts = {
    ["<space>c"] = "console",
    ["<space>ec"] = "elixir-console",
    ['<space>sv'] = 'server',
    ['<space>th'] = ':-1',
    ['<space>tl'] = ':+1',
    ['<space>ts'] = 'shell',
    ['<space>tt'] = 'tests',
    ['<space>tvl'] = 'libvim',
    ['<space>tvm'] = 'mainvim',
    ['<space>tvs'] = 'specvim',
    ['<space>tvt'] = 'testvim',
  }

  for shortcut, selection_target in pairs(shortcuts) do
    it(shortcut .. " has the correct " .. selection_target, function()
      vim.keymaps.n[shortcut]()
      assert.stub(os.execute).was.called_with("tmux select-window -t " .. selection_target)
    end)
  end

  it('navigates to the last window', function()
    vim.keymaps.n['<space>ta']()
    assert.stub(os.execute).was.called_with("tmux select-window -l")
  end)

  it('reruns the commands in the last window', function()
    vim.keymaps.n['<space>taa']()
    assert.stub(os.execute).was.called_with('tmux send-keys -t {last} "Up" C-m && tmux select-window -t {last}')
    assert.are.same({'write!'}, vim.commands)
  end)

end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
