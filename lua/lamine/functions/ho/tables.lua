-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function at(n, default)
  return function(subject)
    return subject[n] or default
  end
end

return {
  at = at,
  first = at(1),
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
