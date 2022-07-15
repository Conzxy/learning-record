#!/bin/bash
echo "Compare test"
echo

echo '$3/$2 >= 0.5: '
awk 'BEGIN { FS = "\t" } $3/$2 >= 0.5' countries
echo

echo '$0 >= "M": '
awk 'BEGIN { FS = "\t" } $0 >= "M"' countries
echo
