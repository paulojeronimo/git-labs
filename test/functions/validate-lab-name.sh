#!/usr/bin/env bash
# Purpose: Test functions/validate-lab-name.sh
#
set -eou pipefail
BASE_DIR=`cd "$(dirname "$0")"/../..; pwd`

# Include common variables and functions used by this test
source "$BASE_DIR"/test-lib/test.sh

# Do the tests ...
test: "$script_in_test should return a valid lab name"
cat <<EOF | clitest -
$ test-function.sh $script_in_test $scripts_dir lab111.sh
lab111.sh
$ test-function.sh $script_in_test $scripts_dir 111
lab111.sh
EOF
