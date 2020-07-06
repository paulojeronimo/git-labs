#!/usr/bin/env bash
# Purpose: run a valid lab file.
# References:
#   Ref1: https://stackoverflow.com/questions/37224634/what-does-bash-s-do
#   Ref2: https://stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash
#
source "$BASE_DIR"/functions/validate-lab-name.sh
source "$BASE_DIR"/functions/validate-lab-contents.sh

_run() {
  # Ref1
  bash -s $1 ${2:-} <<'EOF'
set -eou pipefail
BASE_DIR=`cd "$(dirname "$0")";pwd`
header="Creating and change current directory to your lab dir: ${1%.sh} ... "
echo -n "$header"
count=$(echo $header | wc -c)
(( count += 2 ))
rm -rf ${1%.sh}; mkdir $_; cd $_
echo ok
# Ref2
printf '=%.0s' `seq 1 $count`; echo
! [ "${2:-}" = "-x" ] || set -x
source "$BASE_DIR"/$1
main && ret=0 || ret=$?
{ set +x; } 2> /dev/null
printf '=%.0s' `seq 1 $count`; echo
[ $ret = 0 ] &&
  echo -e "Congratulations! 😃 Your lab exit with sucess!" ||
  echo "Sorry! 🙁 Your lab exits with status code $ret!"
EOF
}

run-lab() {
  [ "${1:-}" ] || { echo "which lab?"; exit 1; }
  local lab_name
  if lab_name=$(validate-lab-name $1); then
    if validate-lab-contents $lab_name; then
      _run $lab_name ${2:-}
    else
      echo "lab \"$lab_name\" doesn't have a valid content!"
    fi
  else
    echo "lab \"$1\" isn't a valid lab file!"
  fi
}
