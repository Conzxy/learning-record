#!/bin/bash
eval $@
if [ $? -eq 0 ]; then
# echo "$CMD ..."
  echo "$@ executed successfully"
else
  echo "$@ terminalted unsuccessfully"
fi
