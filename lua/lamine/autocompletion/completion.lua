-- local dbg = require("debugger")
-- dbg.auto_where = 2

local completers = require'lamine.autocompletion.completers'

local ft_completions = {
  ruby = {
    ["^(%s*)case.*(%s*)$", 
    
  },
}
local function complete_with(completion, ctxt)
  
end

local function find_general_completion(ctxt)
  
end

local function find_ft_completion(ctxt)
  local completions = ft_com
  
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

return {
  complete_with = complete_with,
  find_completion = find_completion,
}

-- SPDX-License-Identifier: AGPL-3.0-or-later
