#!/usr/bin/env bash
# Purpose: Test build.sh
# References:
#   Ref1: https://stackoverflow.com/a/38978201[How to print lines between two patterns, inclusive or exclusive (in sed, AWK or Perl)?^]
#
set -eou pipefail
BASE_DIR=`cd "$(dirname "$0")/.."; pwd`

# Include common variables and functions used by this test
source "$BASE_DIR"/test-lib/test.sh

# HEADER of each script starts on line 2 and terminates
# with an empty comment (without including it, of course).
# See Ref1 to understand the pattern below:
header_pattern='2,/^#$/{/^#$/!p;}'
header_lines=3

test: "Header should have at least $header_lines line(s)"
cat <<EOF | clitest -
$ (( $(sed -n "$header_pattern" $script_in_test | wc -l | tr -d '[:space:]') >= $header_lines )) #=> --exit 0
EOF

test: "Header should have at least a \"Purpose\" and one (1) reference \"References.Ref1\""
cat <<EOF | clitest -
$ sed -n '$header_pattern' $script_in_test | cut -c 3- | yq r - Purpose #=> --lines 1
$ sed -n '$header_pattern' $script_in_test | cut -c 3- | yq r - References.Ref1 #=> --lines 1
EOF
