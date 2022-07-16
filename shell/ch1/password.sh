#!/bin/bash
echo "Enter password: "
# disable echo output
stty -echo
read password
# enable echo output
stty echo
echo
echo "Password: $password"
