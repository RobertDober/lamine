local LNB = "^.*:(%d+)$"
local nerd_tree = ' -c "NERDTree ."'
local command = 'nvim -u ~/gh/lua/lamine/lamine.lua'
local options = ''

local function file_and_lnb(file)
  if string.match(file, LNB) then
    local lnb = string.gsub(file, LNB, "%1")
    print(lnb)
    local file = string.gsub(file, ":%d+$", "") 
    return file .. ' -c "tabnew '.. file ..'|normal ' .. lnb .. 'Gzz"'
  end
  return file 
end

local function mk_directive(dir, arg)
  if dir == "cs" then
    return '-c "colorscheme ' .. arg .. '"'
  end
  if string.match(arg, "^%d+$") then
    return '-c "tabnew '.. dir ..'|normal ' .. arg .. 'Gzz"'
  end
  return ""
end

local function mk_command(arg)
  if arg == '--help' or arg == '-h' or arg == ':h' or arg == ':help' then
    command = "colorize -ax << ${Lamine}/help/startup.xml" 
    nerd_tree = ''
    options = ''
    return 42
  end
  local directive, argument = string.match(arg, "^([^:]+):(.*)$")
  if directive then
    return mk_directive(directive, argument)
  end
  return arg
end

for _, file in ipairs(arg) do
  local option = mk_command(file)
  if option == 42 then
    break
  end
  options = options ..' ' .. option
end
command = command .. nerd_tree .. options

if os.getenv("DEBUG_LAMINE") or os.getenv("DEBUG_LAMINE_STARTUP") then
  print(command)
end
os.execute(command)
