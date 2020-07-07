#!/usr/bin/env bash
# Purpose: Generates README.adoc and other docs.
# References:
#   Ref1: https://stackoverflow.com/a/46083970[Insert newline (\n) using sed^]
#   Ref2: https://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash
#

generate-included-files() {
  # Ref2
  declare -r -A included_files=(
    ["tmp/test-all.txt"]="./test/all.sh"
  )
  local included_files
  mkdir -p tmp
  for f in "${!included_files[@]}"
  do
    [ -f "$f" ] || ${included_files[$f]} | tee $f
  done
}

generate-docs() {
  local adoc_args=$@
  cp functions/README.adoc README.adoc
  cat >> README.adoc <<EOF

[%reversed]
$(for f in `ls lab???.sh | sort -r`
  do
    d=$(git log --diff-filter=A --follow --format=%aI -1 -- $f)
    # Ref1: used in the next 3 lines
    sed -n '2p' $f | sed -E "s/^# Purpose: (.*)/\
. link:$f[]: \1\\
.. Created in $d/"
  done)
EOF

  if $(which asciidoctor &> /dev/null); then
    asciidoctor README.adoc $adoc_args
    generate-index-for docs
    generate-included-files
    for f in docs/*.adoc; do asciidoctor $f; done
  fi
}
