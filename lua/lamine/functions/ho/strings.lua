-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function match_with(pattern, all)
  if all then
    return function(subject) 
      return string.match(subject, pattern)
    end
  else
    return function(subject) 
      return {string.match(subject, pattern)}
    end
  end
end

local function prefix_with(prefix)
  return function(subject)
    return prefix .. subject
  end
end

return {
  match_with = match_with,
  prefix_with = prefix_with,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
