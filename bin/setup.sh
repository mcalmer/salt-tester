#!/bin/bash

source etc/config

echo "Setting up the Salt environment"

if [ -d $SALT_ROOT ]; then
    rm -rf $SALT_ROOT
fi

mkdir $SALT_ROOT

cat <<EOF > $SALT_ROOT/master
user: $USER
pidfile: $SALT_ROOT/run/salt-master.pid
root_dir: $SALT_ROOT
pki_dir: $SALT_ROOT/pki/
cachedir: $SALT_ROOT/cache/
EOF

cat <<EOF > $SALT_ROOT/minion
user: $USER
master: localhost
pidfile: $SALT_ROOT/run/salt-minion.pid
root_dir: $SALT_ROOT
pki_dir: $SALT_ROOT/pki/
cachedir: $SALT_ROOT/cache/
EOF

salt-master -c $SALT_ROOT -d
salt-minion -c $SALT_ROOT -d

sleep 10
