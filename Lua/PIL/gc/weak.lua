#!/bin/lua
a = {}
key = { 1 } 
a[key] = 1
setmetatable(key, { __gc = function (obj) print(obj) end })

print ("first collect")
collectgarbage()
a[key] = nil

print ("second collect")
collectgarbage()
print(collectgarbage("count"))

for _, v in pairs(key) do
  print(v)
end

table.remove(key)

print("third collect")
print(collectgarbage("count"))

