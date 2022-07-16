#prepend() { [ -d "$2" ] && eval $1=\"$2':'\$$1\" && export $1; }
prepend() { eval $1=$2\${$1:+':'\$$1} && export $1; }

prepend X ssssss
