#!/bin/bash

source etc/config

echo "Running tests as $USER"

# Test minion key. This is the main test, which required
# to pass prior anything else is going.
if [ -z $($SALT_KEY_CMD --list-all | grep $HOST) ]; then
    $SALT_KEY_CMD --list-all
    echo "Cannot find $HOST in keys"
    exit 1
else
    $SALT_KEY_CMD -A --yes
    $SALT_KEY_CMD --list-all
    echo "Minion Test Key passed"
fi

# XXX: This sucks to the level 99. Force "SUSE" distro, in case we are in OBS
if [ $($SALT_CALL grains.get os_family | sed -e 's/.*:[ ]*//g') != "Suse" ]; then
    $SALT_CALL grains.set 'os' 'Linux'
    $SALT_CALL grains.set 'os_family' 'Suse'
fi

# Run tests
for TEST_CASE in $(cat etc/progression | grep -v '^#'); do
    echo "------------------------------------------------[$TEST_CASE]"
    if [ $OUTPUT_MODE == "sparse" ]; then
	tests/$TEST_CASE > /dev/null
    else
	tests/$TEST_CASE
    fi

    if [ $? -ne 0 ]; then
	echo -e "TEST FAILED\n\n"
	cat etc/fail
	exit 1
    else
	echo -e "TEST PASSED\n\n"
    fi
done

cat etc/success

