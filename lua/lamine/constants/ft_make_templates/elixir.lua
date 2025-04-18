-- local dbg = require("debugger")
-- dbg.auto_where = 2

local A = require'tools.active_support'
local P = require'tools.path'

local path = P.upto_dir(nil, 'lib', {{'-', '_'}})

return {
  lines = {
    'defmodule ' .. A.camelize_path(path) .. ' do',
    '  @moduledoc ~S"""',
    '  ',
    '  """',
    '  ',
    'end',
  },
  lnb = 5
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
