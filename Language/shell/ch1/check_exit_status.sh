#!/bin/bash
echo "ls +"
ls + 2> "/dev/null"
echo "Exit status: $?"

echo "ls"
ls 1> "/dev/null"
echo "Exit status: $?"
