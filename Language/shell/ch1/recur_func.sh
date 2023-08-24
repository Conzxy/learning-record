#!/bin/bash
F() { echo $1; F hello; sleep 1; }
F AA
