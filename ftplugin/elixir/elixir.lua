-- local dbg = require("debugger")
-- dbg.auto_where = 2

local context = require'lamine.context'
local function append_text(text, strip)
  return function() 
    local ctxt = context.current_context()
    local line = ctxt.line
    if strip then
      line = string.gsub(line, "%s$", "")
    end
    context.set_current_line(line .. text)
    context.api.set_row_col{}
  end
end



vim.keymap.set('i', '<Tab>--', append_text(' -> ', true), {remap=false})
vim.keymap.set('i', '<Tab>-l', append_text(' |> ', true), {remap=false})
-- SPDX-License-Identifier: AGPL-3.0-or-later
