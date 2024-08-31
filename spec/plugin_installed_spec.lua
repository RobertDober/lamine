-- local dbg = require("debugger")
-- dbg.auto_where = 2
require'lamine'
describe("lamine is installed", function()
  it("has a version", function()
    assert(string.match(vim.g.lamine_version, "%d+%.%d+%.%d+"))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
