#!/usr/bin/env bash
set -eou pipefail
BASE_DIR=`cd "$(dirname "$0")"; pwd`
cd "$BASE_DIR"

if ! [[ ${1:-} =~ ^\.\./functions/.+ ]]
then
  echo "You did'nt pass a valid function!"
  exit 1
elif ! [ -f ${1:-} ]
then
  echo "Function is a valid file!"
  exit 1
elif ! source ${1:-} &> /dev/null
then
  echo "Could not source ${1:-}!"
  exit 1
fi

fn=${1##*/}
fn=${fn%.sh}

shift && dir=$1 || {
  echo "You must specifiy the directory where the function will run!"
  exit 1
}
cd $dir || {
  echo "Directory $dir is invalid!"
  exit 1
}

shift || :
$fn "${@:-}"
