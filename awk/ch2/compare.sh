#!/bin/bash
echo "Compare test"
echo

echo "\$3/\$2 >= 0.5"
awk '$3/$2 >= 0.5' countries
echo

echo "\$0 >= "M""
awk '$0 >= "M"' countries
echo
