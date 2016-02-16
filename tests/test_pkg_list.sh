#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

# Setup
CMD="pkg.list_pkgs"
INFO="Listing installed packages should work"

# Tell what you want to do
describe "\${CMD}" "\${INFO}"

$SALT_CALL $CMD || false
