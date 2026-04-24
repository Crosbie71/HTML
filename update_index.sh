#!/bin/bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "const FILE_LIST = [" > "$DIR/filelist.js"

for f in "$DIR"/*.html "$DIR"/*.htm; do
    [ -f "$f" ] || continue
    fname=$(basename "$f")
    [ "$fname" = "index.html" ] && continue
    fdate=$(date -r "$f" "+%d/%m/%Y %H:%M")
    echo "  { name: \"$fname\", modified: \"$fdate\" }," >> "$DIR/filelist.js"
done

echo "];" >> "$DIR/filelist.js"

echo "filelist.js updated!"
