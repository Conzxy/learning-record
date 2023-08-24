#!/bin/bash
str1=""
str2=" Non empty"

if [[ -z $str1 ]] && [[ -n $str2 ]]; then
  echo "$str1 is empty string"
  echo "$str2 is non-empty string"
fi
