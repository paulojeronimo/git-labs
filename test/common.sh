#!/usr/bin/env bash
# Purpose: Verify the prerequisites and expose some variables and functions to your bash tests
# References:
#   Ref1: https://github.com/aureliojargas/clitest[clitest]
#   Ref2: https://unix.stackexchange.com/questions/19323/what-is-the-caller-command[What is the “caller” command?]
#   Ref3: https://stackoverflow.com/questions/28114999/what-are-the-rules-for-valid-identifiers-e-g-functions-vars-etc-in-bash[What are the rules for valid identifiers (e.g. functions, vars, etc) in Bash?]

if ! which clitest &> /dev/null
then
  echo "clitest (Ref1 in common.sh) should be installed!"
  exit 1
fi

# All scripts at test are inside scripts_dir
scripts_dir=..

# Get the name of the script at test by discovering who is calling this file (through the source command - Ref2).
script_in_test=`caller | cut -f 2`
script_in_test=$scripts_dir/${script_in_test##*/}

test_counter=0
# A Bash function could contain ":" in its name (See Ref3)
test:() { echo "Test #$((++test_counter)) in ${script_in_test##*/}: $@"; }
