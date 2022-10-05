#!/bin/lua
N = 8
g_solution_number = 0

function CanPlace(queens, x, y)
  for i = 0, x-1 do
    if (queens[i] == y) or
       (queens[i] - i == y - x) or
       (queens[i] + i == y + x) then
    return false;
    end
  end
  return true;
end

function PrintSolution(queens)
  io.write("number = ", g_solution_number, "\n")
  g_solution_number = 1 + g_solution_number
  for i = 0, N-1 do
    for j = 0, N-1 do
      io.write(queens[i] == j and "Q" or "-", " ")
    end
    io.write("\n")
  end
  io.write("\n")
end

function AddQueen(queens, x)
  if x == N then
    PrintSolution(queens)
  else
    for y = 0, N-1 do
      if CanPlace(queens, x, y) then
        queens[x] = y
        AddQueen(queens, x+1)
      end
    end
  end
end

AddQueen({}, 0)
io.write("Total number of solution: ", g_solution_number, "\n")
