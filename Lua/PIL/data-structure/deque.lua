function NewDeque()
  -- first and last is the index of element
  -- Don't like C++, last don't represent a end iterator
  return { first = 0, last = -1 }
end

function Size(deque)
  return deque.last - deque.first + 1
end

function PushFront(deque, value)
  -- advance at first
  deque.first = deque.first - 1
  deque[deque.first] = value
end

function PopFront(deque)
  -- If deque.first == deque.last, the size is 1
  assert(deque.first <= deque.last, "Deque is empty!")
  deque[deque.first] = nil -- gabage
  deque.first = deque.first + 1
end

function PushBack(deque, value)
  deque.last = deque.last + 1
  deque[deque.last] = value
end

function PopBack(deque, value)
  assert(deque.first <= deque.last, "The deque is empty!")
  deque[deque.last] = nil -- gabage
  deque.last = deque.last - 1
end

function Front(deque)
  return deque[deque.first]
end

function Back(deque)
  return deque[deque.last]
end

function DequePrint(deque)
  for i = deque.first, deque.last do
    io.write(deque[i], " ")
  end
  io.write("\n")
end

deque = NewDeque()

PushFront(deque, 1)
assert(Size(deque) == 1)
assert(Front(deque) == 1)

PushBack(deque, 2)
assert(Size(deque) == 2)
assert(Back(deque) == 2)

DequePrint(deque)
