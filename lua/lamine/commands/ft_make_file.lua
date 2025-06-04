-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local context = require'lamine.context'

local subtype_templates = {
  ruby_spec = require'lamine.constants.ft_make_templates.ruby_spec',
}

local templates = {
  elixir = require'lamine.constants.ft_make_templates.elixir',
  lua = require'lamine.constants.ft_make_templates.lua',
  ruby = require'lamine.constants.ft_make_templates.ruby',
}

local licenses = {
  apache = "SPDX-License-Identifier: Apache-2.0",
  agpl = "SPDX-License-Identifier: AGPL-3.0-or-later",
}

local function completion_function()
  return {'apache', 'agpl'}
end

local function make_license_string(license)
  local license = licenses[license] or ''
  return string.gsub(vim.o.commentstring, '%%s', license)
end

local function ft_function(ft, license)
  local ctxt = context.current_context()
  -- vim.print{subtype=ctxt.subtype}
  local template_data = subtype_templates[ctxt.subtype]
  -- vim.print{subtype_template = template_data}

  if not template_data then
    -- vim.print{templates = templates}
    template_data = templates[ft]
    -- vim.print{ft_template = template_data}
  end

  if not template_data then
    error('no template data found for filetype: "' .. ft .. '"')
  end

  if type(template_data) == 'function' then
    template_data = template_data(context.current_context())
  end

  local license_string = make_license_string(license or 'agpl')
  return {
    lines = append(template_data.lines, {license_string}),
    lnb = template_data.lnb,
    col = template_data.col,
  }
end

return  {
  completion_function = completion_function,
  ft_function = ft_function,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
