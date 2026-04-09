#!/bin/bash

if [ $# -eq 0 ]; then
    exit 1
fi

convert_with_pdftoppm() {
    local input="$1"
    local out_prefix="$2"
    pdftoppm -png "$input" "$out_prefix" >/dev/null 2>&1
}

convert_with_magick() {
    local input="$1"
    local out_prefix="$2"
    magick -density 200 "$input" "${out_prefix}-%03d.png" >/dev/null 2>&1
}

convert_with_ffmpeg() {
    local input="$1"
    local out_prefix="$2"
    /usr/bin/ffmpeg -y -i "$input" "${out_prefix}-%03d.png" >/dev/null 2>&1
}

for f in "$@"; do
    [ -f "$f" ] || continue

    dir=$(dirname -- "$f")
    base=$(basename -- "$f")
    stem="${base%.*}"
    out_prefix="${dir}/${stem}-page"

    if command -v pdftoppm >/dev/null 2>&1; then
        convert_with_pdftoppm "$f" "$out_prefix"
    elif command -v magick >/dev/null 2>&1; then
        convert_with_magick "$f" "$out_prefix"
    elif command -v /usr/bin/ffmpeg >/dev/null 2>&1; then
        convert_with_ffmpeg "$f" "$out_prefix"
    else
        exit 1
    fi

done
