#!/bin/bash
for i in {1..6}; do
  set -x # Enable 
  echo $i
  set +x # Disable debug mode, to avoid print for i in {1..6}
done

echo "Script executed"
