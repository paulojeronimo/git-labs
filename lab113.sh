#!/usr/bin/env bash
# Purpose: Publish a GitHub Pages branch (gh-pages) with the HTML content of this repo.
# References:
#   Ref1: https://www.tldp.org/LDP/abs/html/subshells.html
#   Ref2: https://stackoverflow.com/questions/42871542/how-can-i-create-a-git-repository-with-the-default-branch-name-other-than-maste
#
main() {
  # Generate HTML:
  "$BASE_DIR"/build.sh --html

  # Copy origin files to this directory in parallel
  declare -i id=-1
  for f in $(find .. -type f \( \
    -name '*.html' -o \
    -name '*.sh' \))
  do
    (cd ..; rsync -R ${f#*/} $OLDPWD/) &
  done

  # Ref1: wait for all rsync child process to finish
  wait

  git init

  # Ref2: set default branch name as gh-pages
  git checkout -b gh-pages

  # Copy origin from sources
  origin=$(cd ..; git remote get-url origin)
  git remote add origin $origin

  # User and repo comes from origin
  local user_repo=$(echo $origin | sed 's/\(.*:\)\(.*\).git/\2/')

  # Generate a README with a link to
  cat > README.adoc <<EOF
http://${user_repo%/*}.github.io/${user_repo#*/}
EOF

  git add .
  git commit -m "Published from source code commited with id `cat ../tmp/SOURCE.id`"

  # Push this branch (forcing override)
  git push -f origin gh-pages
}
