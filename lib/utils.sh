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
