#!/bin/bash
alias lsg='ls | grep'
#lsg sh

alias wont_work='/sbin/ifconfig | grep'
#wont_work eth0

function GetIP() { /sbin/ifconfig $1 | grep 'inet'; }
GetIP eth0

# The difference of function and alias is
# alias append argument only
# but function can accept arguments and put in anywhere in the command
