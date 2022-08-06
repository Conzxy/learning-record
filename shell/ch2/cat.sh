#!/bin/bash
echo -e "line1\n\n\nline2\n\n\nline3\n\n\n"> multi_blanks

echo "Orginal multi_blanks: "
cat multi_blanks

echo "squeeze the extra blanks: "
cat -s multi_blanks


echo -e "line1	line2	line3"> tab_lines
echo "Orignal tab_lines: "
cat tab_lines
echo "tab with ^I: "
cat -T tab_lines

echo "with line number: "
cat -n multi_blanks

cat multi_blanks> multi_blanks
ls -hl | grep multi_blanks

rm tab_lines
rm multi_blanks
