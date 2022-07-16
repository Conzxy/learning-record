#!/bin/bash
# For root user, the UID = 0
if [ $UID -ne 0 ]; then
# if test $UID -ne 0:1
# then
  echo 'Non root user. Please run as root'
else
  echo 'Root user'
fi
