#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

# Setup
CMD="test.ping"
INFO="Ping!"

# Tell what you want to do
describe "\${CMD}" "\${INFO}"

$SALT_CALL $CMD || false
