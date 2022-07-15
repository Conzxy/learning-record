#!/bin/bash
echo "Print test"
echo

awk 'BEGIN { FS = "\t"
     printf("%10s %6s %5s  %s\n\n",
            "Country", "Area", "Pop", "Continent")
           }
           { printf("%10s %6d %5d  %s\n", $1, $2, $3, $4)
             area = area + $2
             pop = pop + $3
           }
    END { printf("\n%10s %6d %5d\n", "Total", area, pop) }' countries
