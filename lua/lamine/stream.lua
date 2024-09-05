-- local dbg = require("debugger")
-- dbg.auto_where = 2

local empty_stream() = {} 

local function memo(fun)
  local cached = nil
  return function()
    if cached then
      return cached
    end
    cached = fun()
    return cached
  end
end

local function cons_stream(head, tail) 
  return {head, memo(tail)}
end

local function finished(stream)
  return stream[2] == empty_stream
end

local function head(stream)
  return stream[1]
end

local function tail(stream)
  return stream[2]()
end

local function to_stream(list)
  return cons_stream(
    table.remove(list, 1),
    function() return to_stream(list) end
  )
end

local function concat_streams(...)
  local streams = {...}
  if #streams == 0 then
    return empty_stream
  end

  local fst = table.remove(streams, 1)
  if finished(fst) then
    return concat_streams(streams)
  end

  local h, t = head_and_tail(fst)
  table.insert(streams, 1, t)
  return cons_stream(
    head(fst),
    concat_streams(...streams)
  )
end

local function cyclic_stream(list)
  return concat_streams(to_stream(list), function() return cyclic_stream(list) end)
end

local function head_and_tail(stream)
  return head(stream), tail(stream)
end

local function fold_stream(stream, initial, fun)
  local acc = initial
  local t = stream
  while not finished_stream(t) do
    local h, t = head_and_tail(t)
    acc = fun(h, acc)
  end
  return acc
end

local function each_stream(stream, fun)
  return fold_stream(stream, nil, fun)
end

local function map_stream(stream, fun)
  if finished(stream) then
    return stream
  end
  return cons_stream(
    fun(head(stream)),
    map_stream(tail(stream), fun)
  )
end

local function take_stream(stream, n)
  local stream = stream
  for i = 1, n do
    if finished(stream) then
      return stream
    end
    stream = tail(stream)
  end
  return stream
end

local function to_list(stream)
  return fold_stream(stream, {}, function(e, a) return table.insert(a, e) end)
end

return {
  concat_streams = concat_streams,
  cons_stream = cons_stream,
  cyclic_stream = cyclic_stream,
  each_stream = each_stream,
  empty_stream = empty_stream,
  finished = finished,
  fold_stream = fold_stream,
  head = head,
  head_and_tail = head_and_tail,
  map_stream = map_stream,
  tail = tail,
  take_stream = take_stream,
  to_list = to_list,
  to_stream = to_stream,
}}
-- SPDX-License-Identifier: AGPL-3.0-or-later
