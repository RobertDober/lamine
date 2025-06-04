-- local dbg = require("debugger")
-- dbg.auto_where = 2

local A = require'tools.active_support'
local P = require'tools.path'

local path = P.upto_dir(nil, 'lib', {{'-', '_'}})

return {
  lines = {
    '# frozen_string_literal: true',
    '',
    'RSpec.describe  do',
    '  ',
    'end',
  },
  lnb = 3,
  col = 14,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
