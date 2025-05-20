-- local dbg = require("debugger")
-- dbg.auto_where = 2

-- vim.print{version=1, name="lamine.init_args"}

local parser = require'lamine.tools.string'
local T = require'lamine.tools.table'

local commands = {}
local files = {}
local dirs = {}
local no_nerd
local in_nerd
local win_count = 0

local flags = {
  nnt = function() no_nerd=true end,
}

local function open_file(file)
  if in_nerd then
    table.insert(commands, 'wincmd l')
    table.insert(commands, 'edit ' .. file)
    in_nerd = false
  else
    if win_count > 0 then
      table.insert(commands, 'tabnew')
    end
    table.insert(commands, 'edit ' .. file)
  end
  win_count = win_count + 1
end

local function open_dir(dir)
  table.insert(commands, 'tabnew')
  table.insert(commands, 'NERDTree ' .. dir)
  in_nerd = true
  win_count = win_count + 1
end

local function add_directory(v)
  table.insert(dirs, v)
end

local function colorscheme(v)
  vim.cmd('colorscheme ' .. v)
end

local keys = {
  cs  = colorscheme,
  dir = add_directory,
  nnt = function() no_nerd=true end,
  req = function(v) require(v) end,
  cmd = function(v) vim.cmd(v) end,
}

local function parse_kv(k, v)
  local fun = keys[k]
  if fun then
    vim.print{key = k, fun = fun}
    return fun(v)
  end
  error("Unknown keyword arg: " .. k)
end

local function parse_flag(v)
  local fun = flags[v]
  if fun then
    return fun(v)
  end
  error("Unknown flag: " .. v)
end

local function open_files_and_dirs()
  for _, file in ipairs(files) do
    open_file(file)
    if #dirs > 0 then
      dir = T.shift(dirs)
      open_dir(dir)
    end
  end

  for _, dir in ipairs(dirs) do
    open_dir(dir)
  end

end

local function main()
  parser.split(vim.env.LAMINE_ARGS, "%S+", function(part)
    if string.sub(part, 0, 1) == ":" then
      parse_flag(string.sub(part, 2))
    else
      kv = parser.split(part, "[^:]+")
      if #kv == 1 then
        table.insert(files, part)
      else
        parse_kv(unpack(kv))
      end
    end
    return 1
  end)

  if #dirs == 0 and not no_nerd then
    dirs = {'.'}
  end

  if #dirs > 0 then
    table.insert(commands, 'NERDTree ' .. T.shift(dirs))
    in_nerd = true
  end

  open_files_and_dirs()

  if vim.env.DEBUG_LAMINE_STARTUP then
    vim.print(commands)
  else
    for _, command in ipairs(commands) do
      vim.cmd(command)
    end
  end
end

args = vim.env.LAMINE_ARGS
vim.print{name='LAMINE_ARGS', value = args}
if args then
  main()
end
-- SPDX-License-Identifier: AGPL-3.0-or-later
