#!/bin/bash
echo "Regular expression test"
echo

echo "/Asia/: "
awk '/Asia/' countries # equivalent '$0 ~ /Asia/'
echo 

echo "/ Asia /: "
awk '/ Asia /' countries
echo


echo '$0 !~ / Asia /: '
awk '$0 !~ / Asia /' countries
echo

echo '($1 ~ /Japan|England/) || ($4 ~ /Asia|North America/)'
awk 'BEGIN { FS = "\t" } ($1 ~ /Japan|England/) || ($4 ~ /Asia|North America/)' countries
echo

echo "[Only number]"
awk '/^[0-9]+$/' number_test
echo

echo "[Only alphabet]"
awk '/^[A-Za-z]+$/' number_test
echo

echo "[Decimal, sign and score is optional]: "
#awk '/^(\+|-)?[0-9]+\.?[0-9]*$/' number_test
awk '/^[+-]?[0-9]+\.?[0-9]*$/' number_test
echo

echo "float point number, sign and exponent is optional"
awk '/^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][+-][0-9]+)?$/' number_test
echo

echo "One letter and it following zero or more letter or digits"
awk '/^[A-Za-z][A-Za-z0-9]*$/' number_test
echo 