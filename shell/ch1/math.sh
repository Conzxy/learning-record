#!/bin/bash
echo "Set two variables: "
no1=4
no2=5
echo "no1 = $no1"
echo "no2 = $no2"

# Perform basic operation directly
echo "Plus operation: "
let result=no1+no2
#result=$[ no1 + no2 ]
echo "no1 + no2 = $result"

echo "increment operation: "
let no1++
echo "Now, no1 = $no1"

echo "decrement operation: "
let no1--
echo "Now, no1 = $no1"

echo "plus assignment: "
let no+=6
echo "no+=6: $no"
echo "Minus assignment: "
let no-=6
echo "no-=6: $no"

result=$[ $no1 + 5 ]
echo "[\$no1 + 5]: $result"

result=$(( no1 + 50 ))
echo "\$(( no1 + 50)): $result"

echo "expr $no1 + $no2: $(expr $no1 + $no2)" 

# bc: precision calculator
echo "echo \"4 * 0.56\" | bc: $(echo "4 * 0.56" | bc)"
no=54
echo "echo \"\$no * 1.5\" | bc: $(echo "$no * 1.5" | bc)"

echo "Decimal places scale with bc: "
echo 'echo "scale=2; 22/7" | bc: '$(echo "scale=2; 22/7" | bc)
echo 'Base conversion with bc: '
no=100
echo 'echo "obase=2;$no" | bc: '$(echo "obase=2;$no" | bc)
no=1111111
echo 'echo "obase=10;ibase=2;$no": '$(echo "obase=10;ibase=2;$no" | bc)

echo "Square root: "
echo "sqrt(1000)" | bc 

echo "exponent calculate: "
echo "10^10" | bc