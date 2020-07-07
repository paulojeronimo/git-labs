#!/usr/bin/env bash
# Purpose: Invoke functions that do some tasks.
# References:
#   Ref1: https://unix.stackexchange.com/a/17405[Print lines between (and excluding) two patterns^]
#
set -eou pipefail
BASE_DIR=`cd "$(dirname "$0")"; pwd`
cd "$BASE_DIR"

source ./functions/generate-docs.sh
source ./functions/generate-index-for.sh
source ./functions/run-lab.sh

generate_adoc_includes=false
adoc_args="-o index.html"
while [ "${1:-}" ]
do
  case "${1:-}" in
    --github)
      # Simulates the GitHub generated README.adoc
      adoc_args="-a env-github $adoc_args"
      ;;
    --gitlab)
      # Simulates the GitLab generated README.adoc
      adoc_args="-a env-gitlab $adoc_args"
      ;;
    --generate-adoc-includes)
      generate_adoc_includes=true
      ;;
    --html)
      generate-docs $generate_adoc_includes $adoc_args
      ;;
    --serve)
      ruby -run -e httpd . -p 8000 &> httpd.log &
      echo $! > httpd.pid
      exit 0
      ;;
    --references)
      # TODO:
      #   - List all references used by all the scripts inside this project
      # Ref1: used in the next line
      sed '1,/^# References:$/d;/^#$/,$d' build.sh
      exit 0
      ;;
    --run)
      shift || :
      run-lab "${@:-}"
      exit 0
      ;;
    --clean)
      git clean -fXd
      find . -maxdepth 1 -type d -name 'lab???' | xargs rm -rf
      exit 0
      ;;
    *)
      echo "Invalid argument: \"${1:-}\""
      exit 1
      ;;
  esac
  shift || :
done
