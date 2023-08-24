#!/bin/bash
data="A,B,C,D"
old_ifs=$IFS
echo "The old ifs is $old_ifs"

IFS=,
echo "The new ifs is $IFS"
for field in $data; do
  echo "field: $field"
done

IFS=$old_ifs
