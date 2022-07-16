#!/bin/bash
# Bash version 4.0
declare -A ass_arr
ass_arr=(['A']=1 ['B']=2)
echo ${ass_arr['A']}
echo ${ass_arr['B']}

echo "Print the list of indexes: "
echo ${!ass_arr[*]}
echo "OR"
echo ${!ass_arr[@]}

echo "Print the list of values: "
echo ${ass_arr[*]}
