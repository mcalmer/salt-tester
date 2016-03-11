#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

# Setup
CMD="grains.get cpuarch"
INFO="Find out x86_64 architecture in grains."

# Tell what you want to do
describe "\${CMD}" "\${INFO}"

# Run the test
$SALT_CALL $CMD | grep x86_64 || false
assert_run

# OS name
CMD="grains.get os"
INFO="Verify OS name"
describe "\${CMD}" "\${INFO}"
if [ -f /etc/os-release ]; then
    $SALT_CALL $CMD --out json | bin/jsontest path=$HOST type=s contains="SUSE"
    assert_run
else
    msg="No /etc/os-release file found."
    skip_tests "\${msg}"
fi

# OS family
CMD="grains.get os_family"
INFO="Verify OS family"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest path=$HOST type=s contains="Suse"
assert_run

# OS code name (pretty name)
CMD="grains.get oscodename"
INFO="Verify OS code name (pretty name)"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest path=$HOST type=s contains=$(cat /etc/os-release | grep PRETTY | sed -e 's/\"//g' | sed -e 's/.*=//')
assert_run


# OS full name
CMD="grains.get osfullname"
INFO="Verify OS full name"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest path=$HOST type=s contains=$(cat /etc/os-release | grep '^NAME' | sed -e 's/.*=//' | sed -e 's/"//g')
assert_run

# OS architecture (not CPU arch!)
CMD="grains.get osarch"
INFO="Verify package architecture"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest path=$HOST type=s contains=$(rpm --eval %{_host_cpu})
assert_run

# OS version (don't try that at home)
CMD="grains.get osrelease"
INFO="Verify OS release"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest path=$HOST type=s contains=$(cat /etc/SuSE-release | sed ':a;N;$!ba;s/\n/ /g' | awk '{print $9"."$12}')
assert_run

# OS release info
CMD="grains.get osrelease_info"
INFO="Verify OS release"
describe "\${CMD}" "\${INFO}"
MAJOR=$(cat /etc/SuSE-release | grep VERSION | awk '{print $3}')
MINOR=$(cat /etc/SuSE-release | grep PATCHLEVEL | awk '{print $3}')
[ "2" != $($SALT_CALL $CMD --out json | grep "$MAJOR\|$MINOR" | wc -l) ]
assert_run
