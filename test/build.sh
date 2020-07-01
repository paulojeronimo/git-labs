#!/usr/bin/env bash
# Purpose: Test ../build.sh
# References:
#   Ref1: https://stackoverflow.com/a/38978201[How to print lines between two patterns, inclusive or exclusive (in sed, AWK or Perl)?^]
set -eou pipefail
cd "$(dirname "$0")"

# Include common variables and functions used by this test
source ./common.sh

# HEADER of each script starts on line 2 and terminates
# with an empty comment (without including it, of course).
# See Ref1 to understand the pattern below:
header_pattern='2,/^#$/{/^#$/!p;}'
header_lines=4

test: "Header should have $header_lines lines"
cat <<EOF | clitest -
$ sed -n '$header_pattern' $script_in_test #=> --lines $header_lines
EOF

test: "Header should match a known content with \"Purpose\ and \"References.Ref1\""
cat <<EOF | clitest -
$ sed -n '$header_pattern' $script_in_test | cut -c 3-
Purpose: Generates the README.adoc and do some other things.
References:
  Ref1: https://stackoverflow.com/a/46083970[Insert newline (\n) using sed^]
  Ref2: https://unix.stackexchange.com/a/17405[Print lines between (and excluding) two patterns^]
$ sed -n '$header_pattern' $script_in_test | cut -c 3- | yq r - Purpose
Generates the README.adoc and do some other things.
$ sed -n '$header_pattern' $script_in_test | cut -c 3- | yq r - References.Ref1
https://stackoverflow.com/a/46083970[Insert newline (\n) using sed^]
EOF
