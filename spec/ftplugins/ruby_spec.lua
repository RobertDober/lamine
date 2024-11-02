-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ftp = require'spec_ftplugin'

describe('set options', function()
  setup(function()
    ftp.setup_path('ruby')
    require'ruby'
  end)
  teardown(function()
    ftp.restore_path()
  end)
  it('has line numbers', function()
    assert.is.equal(true, vim.o.number)
  end)
  it('has the correct tabstops', function()
    assert.is.equal(2, vim.o.softtabstop)
  end)
  it('has the correct shiftwidth', function()
    assert.is.equal(2, vim.o.shiftwidth)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
