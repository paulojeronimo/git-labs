#!/usr/bin/env bash
# Purpose: Generates the README.adoc.
# References:
#   Ref1: https://stackoverflow.com/a/46083970[Insert newline (\n) using sed^]
#
generate-README() {
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
    for f in docs/*.adoc; do asciidoctor $f; done
  fi
}
