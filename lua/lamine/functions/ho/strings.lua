-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function match_with(pattern, all)
  if all then
    return function(subject) 
      return {string.match(subject, pattern)}
    end
  else
    return function(subject) 
      return string.match(subject, pattern)
    end
  end
end

local function prefix_with(prefix)
  return function(subject)
    return prefix .. subject
  end
end

local function surround_with(prefix, suffix, index)
  local index = index or 1
  return function(str_or_table)
    local str = str_or_table
    if type(str) == 'table' then
      str = str[index]
    end
    return prefix .. str .. suffix
  end
end

return {
  match_with = match_with,
  prefix_with = prefix_with,
  surround_with = surround_with,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
