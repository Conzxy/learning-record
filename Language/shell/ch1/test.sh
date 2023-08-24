#!/bin/bash
[ -f 'test.sh' ] && echo "This is a regular file"
[ -x 'test.sh' ] && echo "This is a executable file"
[ -d '../ch1' ] && echo "This is a directory path"
[ -e 'test.sh' ] && echo "file exists"
[ ! -e 'ssss' ] && echo "file does not exists"
[ ! -f 'ssss' ] && echo "Not a regular file"
[ -c 'test.sh' ] && echo "This is a character device file"
# -b block file
[ -w 'test.sh' ] && echo "Writable file"
[ -r 'test.sh' ] && echo "Readable file"
[ -L 'test.sh' ] && echo "Symlink"
