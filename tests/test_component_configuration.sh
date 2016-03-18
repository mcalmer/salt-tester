#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

SHIPPED_MASTER_CONFIG="/etc/salt/master"
SHIPPED_MINION_CONFIG="/etc/salt/minion"

# Master
CMD="configuration in the $SHIPPED_MASTER_CONFIG"
INFO="SHA256 explicitly set for the Master"
describe "\${CMD}" "\${INFO}"

[ $(cat $SHIPPED_MASTER_CONFIG | grep -v '^#' | grep hash_type | awk '{print $2}') == "sha25" ]
assert_run

# Minion
CMD="configuration in the $SHIPPED_MINION_CONFIG"
INFO="SHA256 explicitly set for the Minion"
describe "\${CMD}" "\${INFO}"

[ $(cat $SHIPPED_MINION_CONFIG | grep -v '^#' | grep hash_type | awk '{print $2}') == "sha25" ]
assert_run
