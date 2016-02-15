#
# Declare test case
#
function declare {
    eval CMD="$1"
    eval NFO="$2"
    cat <<EOF >&2

Testing: $CMD
   Info: $NFO

EOF
}
