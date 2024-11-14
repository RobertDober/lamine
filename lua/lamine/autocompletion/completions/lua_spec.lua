-- local dbg = require("debugger")
-- dbg.auto_where = 2
local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
local map = require'lamine.functional'.map

-- shorts {{{
local shorts = {
  {'after', 'after_each'},
  {'before', 'before_each'},
  {'setup', 'setup'},
  {'teardown', 'teardown'},
}

local completions = map(shorts, function(shrt)
  return {
    "^(%s*)(" .. shrt[1] .. ")(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, shrt[2] .. '(function()'}, lines={"  ", "end)"}, offset={1, 999}}, 
  }
end)
--  }}}
--  assertions fold3
local assertions = {
  {'ain', 'assert.is_nil('},
  {'aas', 'assert.are.same('},
  {'aie', 'assert.is_equal('},
  {'desc', "describe('"},
}

local assertion_completions = map(assertions, function(assertion)
  return  {
      "^(.*)(" .. assertion[1] .. ")(%s*)$",
      C.replace_matches{nil, assertion[2], ''}
  }
end)
completions = append(completions, assertion_completions)

-- vim.print(completions)
return completions
-- SPDX-License-Identifier: AGPL-3.0-or-later
