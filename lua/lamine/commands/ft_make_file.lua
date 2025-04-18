-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local templates = {
  elixir = require'lamine.constants.ft_make_templates.elixir',
  lua = require'lamine.constants.ft_make_templates.lua',
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
  local template_data = templates[ft]
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
