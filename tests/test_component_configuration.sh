#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

SHIPPED_MASTER_CONFIG="/etc/salt/master"
SHIPPED_MINION_CONFIG="/etc/salt/minion"

# Test the Master and Minion are *shipped* with hash type set to SHA256
# Master
CMD="configuration in the $SHIPPED_MASTER_CONFIG"
INFO="SHA256 explicitly set for the Master"
describe "\${CMD}" "\${INFO}"

[ $(cat $SHIPPED_MASTER_CONFIG | grep -v '^#' | grep hash_type | awk '{print $2}') == "sha256" ]
assert_run

# Minion
CMD="configuration in the $SHIPPED_MINION_CONFIG"
INFO="SHA256 explicitly set for the Minion"
describe "\${CMD}" "\${INFO}"

[ $(cat $SHIPPED_MINION_CONFIG | grep -v '^#' | grep hash_type | awk '{print $2}') == "sha256" ]
assert_run

# Test the Master and Minion are *operating* with the hash type set to SHA256
# NOTE: This comes from the local instance configuration, which is created manually
salt-key -c $SALT_ROOT -f $HOST --output json | bin/jsontest path={"minions","$HOST"} type=s length=95
assert_run
