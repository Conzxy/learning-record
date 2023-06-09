#!/bin/lua
function BagInsert(bag, element)
  bag[element] = (bag[element] or 0) + 1
end

function BagRemove(bg, element)
  local count = bag[element]
  bag[element] = (count and count > 1) and count - 1 or nil
end
