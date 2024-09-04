-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function starts_with(str, target)
  return string.sub(str, 0, #target) == target
end

return {
  starts_with = starts_with,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
