#
# Declare test case
#
function describe {
    eval CMD="$1"
    eval NFO="$2"
    cat <<EOF >&2

Testing: $CMD
   Info: $NFO

EOF
}


#
# Tell why we are skipping the tests
#
function skip_tests {
    eval REASON="$1"
cat <<EOF >&2

    *********************************
              TEST SKIPPED
    ---------------------------------
    Reason:
    $REASON
    *********************************

EOF
}


#
# Terminae, if the last exit code wasn't successful
#
function assert_run {
    if [ $? -ne 0 ]; then
	exit 1
    fi
}
