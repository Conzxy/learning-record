#!/bin/bash
echo 'A1'> a1
echo 'A2'> a2
echo 'A3'> a3

chmod 000 a1
cat a* | tee cat_out | cat -n
cat cat_out
sudo rm a* cat_out
