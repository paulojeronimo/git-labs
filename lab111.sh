#!/usr/bin/env bash
# Purpose: Testing `git merge --squash`.
set -xeou pipefail
cd "`dirname "$0"`"
rm -rf "${0%.*sh}" && mkdir -p "$_" && cd "$_"

# Test starts here ...
source ../lab111.common.sh

git merge --squash fbranch
git commit -m 'Added \"fbranch\" feature branch'
git log --oneline
