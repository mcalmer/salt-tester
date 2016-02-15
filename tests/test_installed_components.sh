#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

# Setup
CMD="--version"
INFO="Call $CMD on each command that supposed to be installed"

# Tell what you want to do
declare "\${CMD}" "\${INFO}"

read -d '' COMPONENTS <<EOF
salt-api
salt-cloud
salt-minion
salt-proxy
salt-ssh
salt-syndic
salt
salt-master
salt-cp
salt-key
salt-run
spm
salt-call
salt-unity
EOF

for CM in $COMPONENTS; do
    $CM --version || false
    if [ $? != 0 ]; then
	echo "Error: $CM not found"
	exit 1
    fi
done
