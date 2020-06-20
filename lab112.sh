#!/usr/bin/env bash
# Purpose: A variant of link:lab111.sh[] producing a more detailed log (link:lab112{outfilesuffix}[read more]).
set -xeou pipefail
cd "`dirname "$0"`"
rm -rf "${0%.*sh}" && mkdir -p "$_" && cd "$_"

# Test starts here ...
source ../lab111.common.sh

git merge fbranch
git reset --soft HEAD~3
message=$(echo -e "Added \"fbranch\" feature branch\n\n$(git log --format=%B --reverse HEAD..HEAD@{1} | awk NF)")
git commit -m "$message"
git log --oneline
