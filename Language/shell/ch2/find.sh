#!/bin/bash
# Like ls
echo "separate with '\n'"
find . -print
echo

echo "separate with 0"
find . -print0
echo

echo "xargs split fields by space or newline"
echo "Create \"file name\""
echo "test"> "file name"
find . -type f -print | xargs ls -l 2> xargs_err
echo 
echo "xargs error message: "
cat xargs_err
echo

find . -type f -print0 | xargs -0 ls -l
echo

echo "Create \"xxxx\""
echo "test"> "xxxx"

find . -type f -print | xargs ls -l 2> xargs_err
echo 
echo "xargs error message: "
cat xargs_err
echo 

echo "Based on name: "
# Do not use double quotes around the *.sh
# shell will expand *.sh to a list
# use single quote to prevent it
find . -name '*.sh' -print

touch example
touch EXAMPLE

echo "Base on name(ignore case): "
find . -iname 'example*' -print

touch xx.pdf
touch xx.txt

echo "Logical operator:"
echo "OR:"
find . \( -name '*.txt' -o -name '*.pdf' \) -print
echo "AND:"
find . \( -name '*s*' -a -name '*h*' \) -print

echo "Restrict the path name"
find /usr/ -path '*/kanon/*' -name 'tcp*' -print

echo "Regex:"
find . -regex '.*\.\(sh\|txt\)$' -print
echo "If you want ignore case, use -iregex"

echo "Exclude match results:"
find . ! -regex '.*\.\(sh\|txt\)$' -print

echo "Based on the depth of dir:"
# -mindepth
find -L /proc -maxdepth 3 2> /dev/null

echo "Based on the type of file:"
echo "directory:"
find . -type d -print # directory
echo "regular file:"
find . -type f -print # regular file
echo "symbolic link:"
find . -type l -print # symbolic link
echo "socket:"
find . -type s -print # socket

echo "Based on timestamp: "
echo "within seven days(1 week):"
find . -type f -atime -7 -print
echo "exact seven days:"
find . -type f -atime 7 -print
echo "over the seven days:"
find . -type f -atime +7 -print
# minute -amin

echo "Based on the file size:"
echo "100 Bytes:"
find . -type f -size +100c
echo "1 block(512 bytes):"
find . -type f -size +1b



rm xargs_err "file name" "xxxx" example EXAMPLE xx.pdf xx.txt
