#!/bin/bash

if ! command -v /usr/bin/ffmpeg >/dev/null 2>&1; then
    exit 1
fi

for f in "$@"; do
    out="${f%.*}.gif"
    tmp_palette="${out}.tmp.palette.png"
    tmp_out="${out}.tmp.gif"

    /usr/bin/ffmpeg -y -threads 8 -i "$f" \
        -vf "fps=15,scale=1280:-1:flags=lanczos,palettegen=stats_mode=diff" \
        "$tmp_palette" >/dev/null 2>&1

    if [ $? -ne 0 ] || [ ! -s "$tmp_palette" ]; then
        rm -f "$tmp_palette" "$tmp_out" "$out"
        continue
    fi

    /usr/bin/ffmpeg -y -threads 8 -i "$f" -i "$tmp_palette" \
        -lavfi "fps=15,scale=1280:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=sierra2_4a" \
        "$tmp_out" >/dev/null 2>&1

    if [ $? -eq 0 ] && [ -s "$tmp_out" ]; then
        mv -f "$tmp_out" "$out"
    else
        rm -f "$tmp_out" "$out"
    fi

    rm -f "$tmp_palette"
done
