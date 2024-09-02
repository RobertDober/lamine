-- local dbg = require("debugger")
-- dbg.auto_where = 2

os = {
  _executed = {}, 
}

function os.execute(cmd)
  table.insert(os._executed, cmd)
end

function os.executed(cmd)
  return table.remove(os._executed)
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
