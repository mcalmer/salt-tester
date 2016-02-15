#!/bin/bash

source etc/config
echo "Cleaning up the Salt environment"

# Stop salt
for p in $(ps uax | grep $SALT_ROOT | grep -v grep | awk '{print $2}'); do kill -9 $p; done

# Remove config
rm -rf $SALT_ROOT
