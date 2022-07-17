#!/bin/bash
# List-oriented for loop
for i in {a..z}; do
  echo "letter loop"
  echo $i
done 

for ((i=0; i < 10; i++)) {
  echo "number loop"
  echo $i
}

count=10
while [ $count -eq 0 ]; do
  echo "while loop"
  echo $count
  let count--
done

x=0
until [ $x -eq 10 ]; do
  echo "until loop"
  echo $x
  let x++
done
