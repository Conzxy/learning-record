#!/bin/bash
fname() {
  echo "The first and second arguments: "
  echo $1, $2
  echo "The all positional arguments in a list: "
  echo '$@=($1..$n)'
  echo "$@"
  echo "Print all elements in \$@: "
  for arg in "$@"; do
    echo $arg
  done

  echo "The all positional arguments concat into a single entity: "
  echo '$*="$1c..c$n"'
  echo "$*"
  echo "Print all elements in \$*: "
  for arg in "$*"; do
    echo $arg
  done
  
  echo "Change IFS to ',', \$*=\$1,..,\$n"
  IFS=,
  echo "$*"

  return 0
}

fname A B
