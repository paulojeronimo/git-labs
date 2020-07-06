#!/usr/bin/env bash
# Purpose: run a valid lab file.
# References:
#   Ref1: https://stackoverflow.com/questions/37224634/what-does-bash-s-do
#
source "$BASE_DIR"/functions/validate-lab-name.sh
source "$BASE_DIR"/functions/validate-lab-contents.sh

_run() {
  # Ref1
  bash -s $1 <<'EOF'
set -xeou pipefail
BASE_DIR=`cd "$(dirname "$0")";pwd`
rm -rf ${1%.sh}; mkdir $_; cd $_
source "$BASE_DIR"/$1
main
EOF
}

run-lab() {
  [ "${1:-}" ] || { echo "which lab?"; exit 1; }
  local lab_name
  if lab_name=$(validate-lab-name $1); then
    if validate-lab-contents $lab_name; then
      _run $lab_name
    else
      echo "lab \"$lab_name\" doesn't have a valid content!"
    fi
  else
    echo "lab \"$1\" isn't a valid lab file!"
  fi
}
