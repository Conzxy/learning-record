#!/bin/bash
if true; then
  echo "true"
fi

if false; then
  echo "branch 1"
elif false; then
  echo "branch 2"
else
  echo "branch 3"
fi

var=11

if [ $var -ne 0 -a $var -gt 2 ]; then
  echo "and test"
fi

# Improve the readable of []
if test true; then echo 'True'; fi
