#!/bin/lua

function mul(a, b)
  if #a == 0 or #b == 0 then
    return {} 
  end
  assert(#a[1] == #b)

  local c = {} -- results
  local M = #a
  local K = #a[1]
  local N = #b[1]

  for i = 1, M do
    c[i] = {} 
    for j = 1, N do
      c[i][j] = 0
      for k = 1, K do
        c[i][j] = c[i][j] + a[i][k] * b[k][j]
      end
    end
  end
  return c
end

function PrintMatrix(mt)
  for i = 1, #mt do
    for j = 1, #mt[1] do
      io.write(mt[i][j], " ")
    end
    io.write("\n")
  end
end

a = {}
a[1] = {1, 2, 0}
a[2] = {2, 0, 3}

b = {}
b[1] = { 1 }
b[2] = { 0 }
b[3] = { 3 }

c = mul(a, b)

PrintMatrix(a)
PrintMatrix(b)
PrintMatrix(c)
