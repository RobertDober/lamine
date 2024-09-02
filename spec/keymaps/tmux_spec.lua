-- local dbg = require("debugger")
-- dbg.auto_where = 2

describe("setting all keymaps for tmux", function()
  setup(function()
    stub(os, "execute")
    require'lamine.keymaps.tmux'
  end)
  teardown(function()
    os.execute:revert()
  end)

  local shortcuts = {
    ["<space>c"] = "console",
    ["<space>ec"] = "elixir-console",
  }
    
  for shortcut, selection_target in pairs(shortcuts) do
    it(shortcut .. " has the correct " .. selection_target, function()
      vim.keymaps.n[shortcut]()
      assert.stub(os.execute).was.called_with("tmux select-window -t " .. selection_target)
    end)
  end
    
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
