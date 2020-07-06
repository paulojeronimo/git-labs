#!/usr/bin/env bash
# Purpose: A variant of link:lab111.sh[] producing a more detailed log (link:docs/lab112{outfilesuffix}[read more]).

main() {
  source "$BASE_DIR"/common/lab111.sh
  git merge fbranch
  git reset --soft HEAD~3
  message=$(echo -e "Added \"fbranch\" feature branch\n\n$(git log --format=%B --reverse HEAD..HEAD@{1} | awk NF)")
  git commit -m "$message"
  git log --oneline
}
