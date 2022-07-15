#!/bin/bash
echo "Regular expression test"
echo

echo "/Asia/: "
awk '/Asia/' countries # equivalent '$0 ~ /Asia/'
echo 

echo "/ Asia /: "
awk '/ Asia /' countries
echo


echo "\$0 !~ / Asia /: "
awk '$0 !~ / Asia /' countries
echo

echo "(\$1 ~ /Japan|England/) || (\$4 ~ /Asia|North America/)"
awk 'BEGIN { FS = "\t" } ($1 ~ /Japan|England/) || ($4 ~ /Asia|North America/)' countries
echo
