#!/bin/bash
echo "List initialization: "
arr1=(1 2 3 4)
echo "Print the first element: "
echo ${arr1[0]}

echo "Print the all elemenets: "
echo ${arr1[*]}

echo "Print the length of array: "
echo ${#arr1[*]}

echo "Index assignment to initialize: "
arr2[0]=5
arr2[1]=6

echo "Print the elements: "
echo ${arr2[*]}

