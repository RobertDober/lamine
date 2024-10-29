-- local dbg = require("debugger")
-- dbg.auto_where = 2

local completers = require'lamine.autocompletion.completers'
local context = require'lamine.context'
local api = require'lamine.api'
local find_value = require'lamine.functional'.find_value

local ft_completions = {
  ruby = {
    {"^(%s*)case.*(%s*)$", nil}, 

  },
  lua = require'lamine.autocompletion.completions.lua',
}

local function complete_with(completion)
  local continue = completion.contiue and error("must not used reserved param continue=, **yet**")
  local count = completion.count or 1
  local ctxt = completion.ctxt or context.current_context()
  local lines = completion.lines or error("missing param lines=")
  local offset = completion.offset or {0, 999}

  api.set_lines(ctxt.lnb, ctxt.lnb + count - 1, lines)
  api.set_cursor(ctxt.fn.relative_offset(offset))
end

local function find_general_completion(ctxt)

end

local function find_match_and_complete(ctxt)
  return function(entry)
    local pattern = entry[1]
    local handler = entry[2]
    -- vim.print{l=ctxt.line, p=pattern}
    local matches = {string.match(ctxt.line, pattern)}
    -- vim.print(matches)
    if matches  and #matches > 0 then
      return handler(matches, ctxt)
    end
  end
end

local function find_ft_completion(ctxt)
  local ft_completion = ft_completions[ctxt.filetype]
  if not ft_completion then
    return
  end
  
  local completion = find_value(ft_completion, find_match_and_complete(ctxt))
  return completion
end

local function find_completion(ctxt)
  local found = find_ft_completion(ctxt)
  if found then
    return found
  end
  found = find_general_completion(ctxt)
  if found then
    return found
  end
end

return {
  complete_with = complete_with,
  find_completion = find_completion,
}

-- SPDX-License-Identifier: AGPL-3.0-or-later
