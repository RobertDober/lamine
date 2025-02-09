-- local dbg = require("debugger")
-- dbg.auto_where = 2

local T = require'lamine.tools.tmux.test'
vim.os = os
local function compile_winaddr(winaddr)
  if not winaddr then
    return " -l"
  end
  if string.match(winaddr, "^[-+]") then
    return " -t :" .. winaddr
  end
  return " -t " .. winaddr
end

local function select_tmux_window(window)
  os.execute('tmux select-window -t ' .. window)
end

local function send_keys(keys)
  -- print("sending to tmux: --------------->")
  -- print(keys)
  os.execute(keys)
end

local function send_and_select_tmux_window(params)
  -- vim.cmd('echomsg "' .. params.window .. '"')
  local command = 'tmux send-keys -t ' .. params.window .. ' "' .. params.command .. '" C-m'
  if params.switch then
    command = command .. ' && tmux select-window -t ' .. params.window
    os.execute(command)
  end
end

local function run_command_and_switch(params)
  vim.cmd('write!')
  send_and_select_tmux_window{
    command = params.command,
    switch  = true,
    window  = params.window 
  }
end

local function switch_to_window(winaddr)
  local compiled = compile_winaddr(winaddr)
  local command = 'tmux select-window' .. compiled
  -- vim.print{['command to be executed'] =  command}

  return os.execute(command)
end

local function test_command()
  local command = T.test_command()
  if command then
    return run_command_and_switch{command = command.command, window=command.window or ':tests'}
  end
  vim.print('ERROR: No test commands found for ft: ' .. vim.o.ft)
end

return {
  run_command_and_switch = run_command_and_switch,
  switch_to_window = switch_to_window,
  send_and_select_tmux_window = send_and_select_tmux_window,
  test_command = test_command, 
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
