#!/bin/bash
pwd
# () operator produce a subshell process
(cd /bin; ls 1> /dev/null 2> /dev/null)
# Then the current working directory is not changed
pwd

echo -e "1\n2\n3\n"> text
echo "Text file: "
cat text

echo '$(cat text)'
echo 'No double quoting: '
out=$(cat text)
echo $out
echo "With double quoting between the variable: "
echo "$out"

echo 'With double quoting: '
out="$(cat text)"
echo $out
echo "With double quoting between the variable: "
echo "$out"

echo "No matter the double quote between subshell operator"
echo "Instead, double quoting the variable can reserve the newline"

rm text
