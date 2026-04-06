#!/bin/bash

if ! command -v /usr/bin/ffmpeg >/dev/null 2>&1; then
    exit 1
fi

for f in "$@"; do
    out="${f%.*}.avif"
    tmp_out="${out}.tmp.avif"

    # 不限制帧数，保留输入动画（如 GIF）到动态 AVIF。
    /usr/bin/ffmpeg -y -threads 8 -i "$f" \
        -map 0:v:0 -an -c:v libaom-av1 -cpu-used 8 -crf 30 -b:v 0 \
        "$tmp_out" >/dev/null 2>&1

    if [ $? -eq 0 ] && [ -s "$tmp_out" ]; then
        mv -f "$tmp_out" "$out"
    else
        rm -f "$tmp_out" "$out"
    fi
done
