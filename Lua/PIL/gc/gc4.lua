#!/bin/lua
do
  local mt = { __gc = function (o)
    print("New cycle")
    setmetatable({}, getmetatable(o))
  end}

  setmetatable({}, mt)
end

collectgarbage()
collectgarbage()
collectgarbage()
