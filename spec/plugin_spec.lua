-- local dbg = require("debugger")
-- dbg.auto_where = 2

require 'lamine'
describe('global information', function()
  it("has a correctly formatted version", function()
    assert(string.match(vim.g.lamine_version, "%d+%.%d+%.%d+"))
  end)
  it("had a correctly formatted date", function()
    assert(string.match(vim.g.lamine_date, "20%d%d%-%d%d%-%d%d"))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
