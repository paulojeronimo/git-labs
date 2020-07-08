#!/usr/bin/env bash
# Purpose: generate a index.adoc file for a directory containing other .adoc files.
#
generate-index-for() {
  local dir=$1
  cat > $dir/index.adoc <<EOF
= $dir
:nofooter:

$(cd $dir; for f in $(find . -maxdepth 1 -name '*.adoc' ! -name index.adoc)
  do
    html=${f%.adoc}.html
    echo "* link:$html[$html]"
  done)
EOF
}
