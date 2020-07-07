#!/usr/bin/env bash
set -eou pipefail

echo "Testing all ..."
echo "==============="

# Function Tests comes first
for testf in ./test/functions/*; do $testf; done

# Test build.sh
./test/build.sh

echo "==============="
echo "Congratulations! 😃 All tests passed!"
