-- local dbg = require("debugger")
-- dbg.auto_where = 2

local completers = require'lamine.autocompletion.completers'
local context = require'lamine.context'
local api = require'lamine.api'
local find_value = require'lamine.functional'.find_value
local report = require'lamine.tools.report'

local ft_completions = {
  lua = require'lamine.autocompletion.completions.lua',
  elixir = require'lamine.autocompletion.completions.elixir',
  fennel = require'lamine.autocompletion.completions.fennel',
  markdown = require'lamine.autocompletion.completions.markdown',
  ruby = require'lamine.autocompletion.completions.ruby',
  rust = require'lamine.autocompletion.completions.rust',
  sh = require'lamine.autocompletion.completions.sh',
  typst = require'lamine.autocompletion.completions.typst',
}

local general_completions = require'lamine.autocompletion.completions.general_completions'

local subtype_completions = {
  elixir_test = require'lamine.autocompletion.completions.elixir_test',
  lua_spec = require'lamine.autocompletion.completions.lua_spec',
  ruby_spec = require'lamine.autocompletion.completions.ruby_spec',
}

local function set_continuation(continue)
  if continue then
    local continuations = vim.b.autocontinuations or {}
    table.insert(continuations, continue)
    vim.b.autocontinuations = continuations
  end
end

local function complete_with(completion)
  -- report{name= 'complete_with', completion=completion}
  local continue = completion.contiue and error("must not used reserved param continue=, **yet**")
  local range = completion.range or {0, 0} 
  local ctxt = completion.ctxt or context.current_context()
  local lines = completion.lines or error("missing param lines=")
  local offset = completion.offset or {0, 999}
  local continue = completion.continue


  api.set_lines(ctxt.lnb + range[1], ctxt.lnb + range[2], lines)
  if completion.set_cursor then
    api.set_cursor(context.current_lnb(), 999)
  end
  -- vim.print{before=offset}
  -- vim.print{col_before=context.col()} 
  offset = ctxt.fn.relative_offset(offset)
  -- vim.print{after=offset}
  api.set_cursor(offset)
  set_continuation(continue)
end

local function find_match_and_complete(ctxt)
  return function(entry)
    local pattern = entry[1]
    local handler = entry[2]
    -- report{label='find_match_and_complete 1', pattern=pattern, handler=handler}
    local matches = {string.match(ctxt.line, pattern)}
    report{label='find_match_and_complete 2', matches=matches}
    if matches and #matches > 0 then
      return handler(matches, ctxt)
    end
  end
end


local function find_general_completion(ctxt)
  local completion = find_value(general_completions, find_match_and_complete(ctxt))
  return completion
end

local function find_ft_completion(ctxt)
  local ft_completion = ft_completions[ctxt.filetype]
  if not ft_completion then
    return
  end
  
  local completion = find_value(ft_completion, find_match_and_complete(ctxt))
  return completion
end

local function find_subtype_completion(ctxt)
  local subtype_completion = subtype_completions[ctxt.subtype]
  -- vim.print(subtype_completion)
  if not subtype_completion then
    return
  end
  
  local completion = find_value(subtype_completion, find_match_and_complete(ctxt))
  return completion
end

local function find_ft_specific_completion(ctxt)
  local found = find_ft_completion(ctxt)
  
  if found then
    return found
  end

  found = find_subtype_completion(ctxt)
  if found then
    return found
  end
  
end

local function find_completion(ctxt)
  local found
  if ctxt.filetype then
    found = find_ft_specific_completion(ctxt)
    if found then
      return found
    end
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
