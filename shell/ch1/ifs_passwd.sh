#!/bin/bash
line="root:x:0:0:root:/root:/bin/bash"
old_ifs=$IFS
IFS=':'
count=0
for field in $line; do
  [ $count -eq 0 ] && user=$field
  [ $count -eq 6 ] && shell=$field
  let count++
done

IFS=$old_ifs
echo "$user's shell is $shell"

echo "Equivalent effect implemented by awk: "
#echo $line | awk 'BEGIN { FS=":" } { printf("%s\'s shell is %s\n", $1, $7) }'
echo $line | awk 'BEGIN { FS=":" } { printf("%s" "\x27" "s shell is %s\n", $1, $7) }'
echo $line | awk "BEGIN { FS=\":\" } { printf(\"%s's shell is %s\n\", \$1, \$7) }"

echo "Print the all users' shell: "
awk 'BEGIN { FS=":" } { printf("%s" "\x27" "s shell is %s\n", $1, $7) }' /etc/passwd
