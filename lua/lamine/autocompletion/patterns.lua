-- local dbg = require("debugger")
-- dbg.auto_where = 2
local function word(replacement)
  return {"^(%s*)(%w+)(%s*)$", replacement}
end

return {
  word = word,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
