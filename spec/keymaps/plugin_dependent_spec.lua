
-- local dbg = require("debugger")
-- dbg.auto_where = 2

local autocomplete = require'lamine.autocompletion'.autocomplete
local commentary_keys = '<Leader>co'
describe('setting keymap for plugins', function()
  describe('Commentary', function()
    describe('not loaded', function()
      setup(function()
        vim.g.loaded_commentary = nil 
        require'lamine.keymaps.plugin_dependent'
      end)
      it('keymapping to commentary is not defined unless the comment plugin is defined', function()
        assert.is_nil(vim.keymaps.n[commentary_keys])
        assert.is_nil(vim.keymaps.v[commentary_keys])
      end)
    end)
    describe('loaded', function()
      setup(function()
        vim.g.loaded_commentary = 1
        require'lamine.keymaps.plugin_dependent'
      end)
      teardown(function()
        vim.g.loaded_commentary = nil 
      end)
      it('keymapping to commentary is not defined unless the comment plugin is defined', function()
        assert.is_nil(vim.keymaps.n[commentary_keys])
        assert.is_nil(vim.keymaps.v[commentary_keys])
      end)
    end)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
