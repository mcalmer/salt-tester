#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

# Setup
CMD="grains.get cpuarch"
INFO="Find out x86_64 architecture in grains."

# Tell what you want to do
declare "\${CMD}" "\${INFO}"

# Run the test
$SALT_CALL $CMD | grep x86_64 || false
