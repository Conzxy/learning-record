#!/bin/bash
repeat_until_fail() {
  # true is a biary in the /bin
  # instead, : is a built-in command
  # that always returns exit code 0

  # while true
  while $@ 
  do
    :
  done
}

repeat_until_success() {
  while :; do $@ && return ; done
}

repeat_until_fail2() 
{
  while :; do $@; [ $? -ne 0 ] && return ; done
}

#repeat_until_success lss
repeat_until_fail lss
#repeat_until_fail2 ls
