-- local dbg = require("debugger")
-- dbg.auto_where = 2

local original_path = nil

return {
  setup_path= function(ft)
    original_path = package.path
    package.path = package.path .. ";ftplugin/" .. ft .. "/?.lua"
  end,
  restore_path = function()
    if original_path then
      package.path = original_path
    end
  end
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
