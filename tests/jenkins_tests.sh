#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

if [ ! -f "/etc/zypp/repos.d/salt_test_packages.repo" ]; then
    zypper ar http://download.opensuse.org/repositories/systemsmanagement:/saltstack:/testing:/testpackages/SLE_12/ salt_test_packages
fi

# Update repo
sudo zypper ref salt_test_packages
sudo zypper --non-interactive in --oldpackage test-package=42:0.0

# Run the tests

# info_installed
CMD="pkg.info_installed test-package"
INFO="Check if pkg.info_installed works"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest \
    path={"$HOST","test-package","vendor"} type=s \
    value="obs://build.opensuse.org/systemsmanagement"
assert_run

# info_installed getting attribute
CMD="pkg.info_installed attr=epoch"
INFO="Check if pkg.info_installed returns an epoch by attribute"
describe "\${CMD}" "\${INFO}"
$SALT_CALL $CMD --out json | bin/jsontest \
    path={"$HOST","test-package","epoch"} type=s value="42"
assert_run

# grains
CMD="grains.items"
INFO="Check if grains contains correct information"
describe "\${CMD}" "\${INFO}"
grains_data=$($SALT_CALL $CMD --out json)
echo "Check 'os_family' for 'Suse'"
echo "$grains_data" | bin/jsontest \
    path={"$HOST","os_family"} type=s value="Suse"
assert_run
echo "Check 'kernel' for 'Linux'"
echo "$grains_data" | bin/jsontest \
    path={"$HOST","kernel"} type=s value="Linux"
assert_run
echo "Check 'cpuarch' for 'x86_64'"
echo "$grains_data" | bin/jsontest \
    path={"$HOST","cpuarch"} type=s value="x86_64"
assert_run

