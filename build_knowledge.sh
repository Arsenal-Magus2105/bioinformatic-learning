#!/usr/bin/env bash
set -euo pipefail
out=PROJECT_KNOWLEDGE_ALL.md
{
  echo "# PROJECT KNOWLEDGE — ban ghep tu dong / auto-generated"
  echo "Sinh luc / Generated: $(date -Iseconds)"
  echo "Ban goc duy nhat / Master copy: CURRICULUM/"
  for f in CURRICULUM/0*.md CURRICULUM/modules/*.md; do
    [ -e "$f" ] || continue
    printf '\n\n---\n\n<!-- nguon: %s -->\n\n' "$f"
    cat "$f"
  done
} > "$out"
echo "Da sinh $out ($(wc -l < "$out") dong)"
