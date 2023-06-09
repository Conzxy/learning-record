#!/bin/lua

function TableLenIndexMetaCallback(tb)
  local len = 0
  return function ()
    len = len + 1
  end
end

function SpareMul(a, b)
  local c = {}
  for i = 1, #a do
    local resultline = {}
    for k, va in pairs(a[i]) do
      for j, vb in pairs(b[k]) do
        local res = (resultline[j] or 0) + va * vb
        resultline[j] = (res ~= 0) and res or nil
      end
    end
    c[i] = resultline
  end
  return c
end

function SpareMul2(a, b)
  local c = {}

  for i = 1, #a do 
    c[i] = {}
    for j = 1, #b do
      for k, va in pairs(a[i]) do
        c[i][j] = b[k][j] and ((c[i][j] or 0) + va * b[k][j]) or nil
      end
    end
  end
  return c
end

a = {}
a[1] = { 1, nil, 3 }
a[2] = { nil, 2, nil }
a[3] = { nil, nil, nil }

b = {}
b[1] = { nil, 2 }
b[2] = { 3, nil }
b[3] = { nil, 1 }


function PrintMatrix(c)
  for i, row in pairs(c) do
    for j, entry in pairs(row) do
      io.write("(", i, ",", j, "): ", entry, " ")
    end
    io.write("\n")
  end
end

PrintMatrix(SpareMul(a, b))
io.write("\n")
PrintMatrix(SpareMul2(a, b))
