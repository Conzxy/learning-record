#!/bin/lua
-- If write local fact = ...,
-- will call the global fact
local fact 
fact = function (n)
  if (n == 0) then return 1
  else return n * fact(n-1)
  end
end

local function fact2(n) 
  if (n == 0) then return 1
  else return n * fact(n-1)
  end
end

print(fact(5))
print(fact2(5))
