#!/bin/bash
#for i in {1..$#}; do
# Shift can access all the arguments in cmd line by $1
for i in $(seq 1 $#); do
  echo $i is $1
  shift
done
