-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'
-- local P = require'lamine.autocompletion.patterns'


return {
  {
    "^(%s*)(%(?)(lo)(%s*)$",
    C.replace_matches{
      nil, '', '(local ',''
    }
  },
  {
    "^(%s*)(%(?)(fn)(%s*)$",
    C.replace_matches{
      nil, '', '(fn ', ''
    }
  },
  {
    "^(%s*)(%(?)(lam)(%s*)$",
    C.replace_matches{
      nil, '', '(λ ', ''
    }
  },
  {
    "^(%s*%(fn%s%S+)(%s*)$",
    C.replace_matches({
      nil, nil, nil, ' []' 
    }, {offset = {0, -1}})
  }
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
