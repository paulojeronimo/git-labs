#!/usr/bin/env bash
# Purpose: validate the passed lab name
#
validate-lab-name() {
  local lab=$1
  local valid=1
  if [[ $lab =~ lab...\.sh ]]; then
    valid=0
  elif [[ $lab =~ ... ]]; then
    lab=lab$lab.sh
    valid=0
  fi
  if [ $valid = 0 ]; then
    [ -f $lab ] && {
      valid=0
      echo $lab
    } || valid=1
  fi
  return $valid
}
