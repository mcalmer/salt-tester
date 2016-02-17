#!/bin/bash

# Include needed parts
source etc/config
source lib/utils.sh

# Configured unit tests
TEST_CONF=$(cat etc/unit_tests)

# Setup
CMD="Unit tests for Salt"
INFO="Run required unit tests from the packaged sources"

# Tell what you want to do
describe "\${CMD}" "\${INFO}"


#
# Rip away the exact sources from the tested package.
# As long this is the corresponding source package... :-/
#
function ut_collect_sources {
    mkdir $SALT_ROOT/src
    SRC="/usr/src/packages"
    # Always install source RPM
    # zypper --non-interactive source-install salt
    if [ ! -f "$SRC/SPECS/salt.spec" ]; then
	msg="Cannot find salt.spec file."
	skip_tests "\${msg}"
	exit 0
    else
	cp $SRC/SPECS/salt.spec $SALT_ROOT/src
    fi

    # Get patches first
    for p_file in $(rpmspec -P $SRC/SPECS/salt.spec | grep -i '^patch' | awk '{print $2}'); do
	if [ ! -f "$SRC/SOURCES/$p_file" ]; then
	    msg="Missing patch: $p_file"
	    skip_tests "\${msg}"
	    exit 0
	else
	    cp $SRC/SOURCES/$p_file $SALT_ROOT/src
	fi
    done

    # Find sources
    for s_file in $(rpmspec -P $SRC/SPECS/salt.spec | grep -i '^source' | awk '{print $2}'); do
	s_file=$(echo $s_file | sed -e 's/.*\///g')
	if [ ! -f "$SRC/SOURCES/$s_file" ]; then
	    msg="Missing source file: $s_file"
	    skip_tests "\${msg}"
	    exit 0
	else
	    cp $SRC/SOURCES/$s_file $SALT_ROOT/src
	fi	
    done
}


#
# Prepare tarball (toss in patches etc)
#
function ut_prepare_sources {
    cd $SALT_ROOT/src
    quilt setup salt.spec > /dev/null
    cd salt*
    quilt -a push > /dev/null
    echo $(pwd)
}


#
# Main
#
PWD=$(pwd)
ut_collect_sources
cd $(ut_prepare_sources)

for test_case in $(echo "$TEST_CONF" | grep -v '^#' | grep -ve '^$' | sed -e 's/ //g'); do
    echo "Unit test: $test_case"
    test_out=$(python tests/runtests.py -n $test_case)
    if [ $? -ne 0 ]; then
	>&2 echo "$test_out"
	exit 1
    else
	echo "$test_out" | grep 'OK (total='
    fi
done

cd $PWD
