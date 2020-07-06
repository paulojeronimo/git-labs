#!/usr/bin/env bash
# Purpose: Testing `git merge --squash`.

main() {
  source "$BASE_DIR"/common/lab111.sh
  git merge --squash fbranch
  git commit -m 'Added \"fbranch\" feature branch'
  git log --oneline
}
